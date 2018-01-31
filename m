Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 31 Jan 2018 16:56:46 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jerome Glisse <jglisse@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Killing reliance on struct page->mapping
Message-ID: <20180131165646.GI29051@ZenIV.linux.org.uk>
References: <20180130004347.GD4526@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180130004347.GD4526@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 29, 2018 at 07:43:48PM -0500, Jerome Glisse wrote:
> I started a patchset about $TOPIC a while ago, right now i am working on other
> thing but i hope to have an RFC for $TOPIC before LSF/MM and thus would like a
> slot during common track to talk about it as it impacts FS, BLOCK and MM (i am
> assuming their will be common track).
> 
> Idea is that mapping (struct address_space) is available in virtualy all the
> places where it is needed and that their should be no reasons to depend only on
> struct page->mapping field. My patchset basicly add mapping to a bunch of vfs
> callback (struct address_space_operations) where it is missing, changing call
> site. Then i do an individual patch per filesystem to leverage the new argument
> instead on struct page.

Oh?  What about the places like fs/coda?  Or block devices, for that matter...
You can't count upon file->f_mapping->host == file_inode(file).
