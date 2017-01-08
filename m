Return-Path: <linux-block-owner@vger.kernel.org>
Received: from gum.cmpxchg.org ([85.214.110.215]:36520 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933164AbdAHCCN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Jan 2017 21:02:13 -0500
Date: Sat, 7 Jan 2017 21:02:00 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Chris Leech <cleech@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>, open-iscsi@googlegroups.com,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [4.10, panic, regression] iscsi: null pointer deref at
 iscsi_tcp_segment_done+0x20d/0x2e0
Message-ID: <20170108020200.GA16312@cmpxchg.org>
References: <20161221221638.GD4758@dastard>
 <CA+55aFyb1jcdpavyZgZ4nedA0=6tLognyWcJXfOJjMPFTm5GWA@mail.gmail.com>
 <20161222001303.nvrtm22szn3hgxar@straylight.hirudinean.org>
 <20161222051322.GF4758@dastard>
 <CA+55aFza=cv6TGYh+Be1xz2x-G-U=vruhbmfGpHSqY1ocZrBeg@mail.gmail.com>
 <alpine.LSU.2.11.1612221204510.4476@eggly.anvils>
 <20161223073241.GA13584@cmpxchg.org>
 <20161223083329.GA13952@cmpxchg.org>
 <20170102211136.GA3189@cmpxchg.org>
 <20170103122825.GC3780@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170103122825.GC3780@quack2.suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 03, 2017 at 01:28:25PM +0100, Jan Kara wrote:
> On Mon 02-01-17 16:11:36, Johannes Weiner wrote:
> > On Fri, Dec 23, 2016 at 03:33:29AM -0500, Johannes Weiner wrote:
> > > On Fri, Dec 23, 2016 at 02:32:41AM -0500, Johannes Weiner wrote:
> > > > On Thu, Dec 22, 2016 at 12:22:27PM -0800, Hugh Dickins wrote:
> > > > > On Wed, 21 Dec 2016, Linus Torvalds wrote:
> > > > > > On Wed, Dec 21, 2016 at 9:13 PM, Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > I unmounted the fs, mkfs'd it again, ran the
> > > > > > > workload again and about a minute in this fired:
> > > > > > >
> > > > > > > [628867.607417] ------------[ cut here ]------------
> > > > > > > [628867.608603] WARNING: CPU: 2 PID: 16925 at mm/workingset.c:461 shadow_lru_isolate+0x171/0x220
> > > > > > 
> > > > > > Well, part of the changes during the merge window were the shadow
> > > > > > entry tracking changes that came in through Andrew's tree. Adding
> > > > > > Johannes Weiner to the participants.

Okay, the below patch should address this problem. Dave Jones managed
to reproduce it with the added WARN_ONs, and they made it obvious. He
cannot trigger it anymore with this fix applied. Thanks Dave!

Linus? Andrew?

---

>From 503eeb20e68bdf3529bdc14aca1ce564880129f2 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 6 Jan 2017 19:21:43 -0500
Subject: [PATCH] mm: workingset: fix use-after-free in shadow node shrinker

Several people report seeing warnings about inconsistent radix tree
nodes followed by crashes in the workingset code, which all looked
like use-after-free access from the shadow node shrinker. Dave Jones
managed to reproduce the issue with a debug patch applied, which
confirmed that the radix tree shrinking indeed frees shadow nodes
while they are still linked to the shadow LRU:

  WARNING: CPU: 2 PID: 53 at lib/radix-tree.c:643 delete_node+0x1e4/0x200
  CPU: 2 PID: 53 Comm: kswapd0 Not tainted 4.10.0-rc2-think+ #3
  Call Trace:
   dump_stack+0x4f/0x73
   __warn+0xcb/0xf0
   warn_slowpath_null+0x1d/0x20
   delete_node+0x1e4/0x200
   __radix_tree_delete_node+0xd/0x10
   shadow_lru_isolate+0xe6/0x220
   __list_lru_walk_one.isra.4+0x9b/0x190
   ? memcg_drain_all_list_lrus+0x1d0/0x1d0
   list_lru_walk_one+0x23/0x30
   scan_shadow_nodes+0x2e/0x40
   shrink_slab.part.44+0x23d/0x5d0
   ? 0xffffffffa023a077
   shrink_node+0x22c/0x330
   kswapd+0x392/0x8f0

This is the WARN_ON_ONCE(!list_empty(&node->private_list)) placed in
the inlined radix_tree_shrink().

The problem is with 14b468791fa9 ("mm: workingset: move shadow entry
tracking to radix tree exceptional tracking"), which passes an update
callback into the radix tree to link and unlink shadow leaf nodes when
tree entries change, but forgot to pass the callback when reclaiming a
shadow node. While the reclaimed shadow node itself is unlinked by the
shrinker, its deletion from the tree can cause the left-most leaf node
in the tree to be shrunk. If that happens to be a shadow node as well,
we don't unlink it from the LRU as we should.

Consider this tree, where the s are shadow entries:

     root->rnode
          |
     [0       n]
      |       |
   [s    ] [sssss]

Now the shadow node shrinker reclaims the rightmost leaf node through
the shadow node LRU:

     root->rnode
          |
     [0        ]
      |
  [s     ]

Because the parent of the deleted node is the first level below the
root and has only one child in the left-most slot, the intermediate
level is shrunk and the node containing the single shadow is put in
its place:

     root->rnode
          |
     [s        ]

The shrinker again sees a single left-most slot in a first level node
and thus decides to store the shadow in root->rnode directly and free
the node - which is a leaf node on the shadow node LRU.

root->rnode
     |
     s

Without the update callback, the freed node remains on the shadow LRU,
where it causes later shrinker runs to crash.

Pass the node updater callback into __radix_tree_delete_node() in case
the deletion causes the left-most branch in the tree to collapse too.

Also add warnings when linked nodes are freed right away, rather than
wait for the use-after-free when the list is scanned much later.

Fixes: 14b468791fa9 ("mm: workingset: move shadow entry tracking to radix tree exceptional tracking")
Reported-by: Dave Chinner <david@fromorbit.com>
Reported-by: Hugh Dickins <hughd@google.com>
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Tested-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/radix-tree.h |  4 +++-
 lib/radix-tree.c           | 11 +++++++++--
 mm/workingset.c            |  3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 5dea8f6440e4..52bda854593b 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -306,7 +306,9 @@ void radix_tree_iter_replace(struct radix_tree_root *,
 void radix_tree_replace_slot(struct radix_tree_root *root,
 			     void **slot, void *item);
 void __radix_tree_delete_node(struct radix_tree_root *root,
-			      struct radix_tree_node *node);
+			      struct radix_tree_node *node,
+			      radix_tree_update_node_t update_node,
+			      void *private);
 void *radix_tree_delete_item(struct radix_tree_root *, unsigned long, void *);
 void *radix_tree_delete(struct radix_tree_root *, unsigned long);
 void radix_tree_clear_tags(struct radix_tree_root *root,
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 6f382e07de77..0b92d605fb69 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -640,6 +640,7 @@ static inline void radix_tree_shrink(struct radix_tree_root *root,
 				update_node(node, private);
 		}
 
+		WARN_ON_ONCE(!list_empty(&node->private_list));
 		radix_tree_node_free(node);
 	}
 }
@@ -666,6 +667,7 @@ static void delete_node(struct radix_tree_root *root,
 			root->rnode = NULL;
 		}
 
+		WARN_ON_ONCE(!list_empty(&node->private_list));
 		radix_tree_node_free(node);
 
 		node = parent;
@@ -767,6 +769,7 @@ static void radix_tree_free_nodes(struct radix_tree_node *node)
 			struct radix_tree_node *old = child;
 			offset = child->offset + 1;
 			child = child->parent;
+			WARN_ON_ONCE(!list_empty(&node->private_list));
 			radix_tree_node_free(old);
 			if (old == entry_to_node(node))
 				return;
@@ -1824,15 +1827,19 @@ EXPORT_SYMBOL(radix_tree_gang_lookup_tag_slot);
  *	__radix_tree_delete_node    -    try to free node after clearing a slot
  *	@root:		radix tree root
  *	@node:		node containing @index
+ *	@update_node:	callback for changing leaf nodes
+ *	@private:	private data to pass to @update_node
  *
  *	After clearing the slot at @index in @node from radix tree
  *	rooted at @root, call this function to attempt freeing the
  *	node and shrinking the tree.
  */
 void __radix_tree_delete_node(struct radix_tree_root *root,
-			      struct radix_tree_node *node)
+			      struct radix_tree_node *node,
+			      radix_tree_update_node_t update_node,
+			      void *private)
 {
-	delete_node(root, node, NULL, NULL);
+	delete_node(root, node, update_node, private);
 }
 
 /**
diff --git a/mm/workingset.c b/mm/workingset.c
index 241fa5d6b3b2..abb58ffa3c64 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -473,7 +473,8 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	if (WARN_ON_ONCE(node->exceptional))
 		goto out_invalid;
 	inc_node_state(page_pgdat(virt_to_page(node)), WORKINGSET_NODERECLAIM);
-	__radix_tree_delete_node(&mapping->page_tree, node);
+	__radix_tree_delete_node(&mapping->page_tree, node,
+				 workingset_update_node, mapping);
 
 out_invalid:
 	spin_unlock(&mapping->tree_lock);
-- 
2.10.2

