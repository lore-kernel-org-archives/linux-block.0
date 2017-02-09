Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 09/10] kobject: Export kobject_get_unless_zero()
Date: Thu,  9 Feb 2017 13:44:32 +0100
Message-Id: <20170209124433.2626-10-jack@suse.cz>
In-Reply-To: <20170209124433.2626-1-jack@suse.cz>
References: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Make the function available for outside use and fortify it against NULL
kobject.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/kobject.h | 2 ++
 lib/kobject.c           | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index e6284591599e..ca85cb80e99a 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -108,6 +108,8 @@ extern int __must_check kobject_rename(struct kobject *, const char *new_name);
 extern int __must_check kobject_move(struct kobject *, struct kobject *);
 
 extern struct kobject *kobject_get(struct kobject *kobj);
+extern struct kobject * __must_check kobject_get_unless_zero(
+						struct kobject *kobj);
 extern void kobject_put(struct kobject *kobj);
 
 extern const void *kobject_namespace(struct kobject *kobj);
diff --git a/lib/kobject.c b/lib/kobject.c
index 445dcaeb0f56..763d70a18941 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -601,12 +601,15 @@ struct kobject *kobject_get(struct kobject *kobj)
 }
 EXPORT_SYMBOL(kobject_get);
 
-static struct kobject * __must_check kobject_get_unless_zero(struct kobject *kobj)
+struct kobject * __must_check kobject_get_unless_zero(struct kobject *kobj)
 {
+	if (!kobj)
+		return NULL;
 	if (!kref_get_unless_zero(&kobj->kref))
 		kobj = NULL;
 	return kobj;
 }
+EXPORT_SYMBOL(kobject_get_unless_zero);
 
 /*
  * kobject_cleanup - free kobject resources.
-- 
2.10.2
