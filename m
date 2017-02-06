Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/4 v2] BDI lifetime fix
Date: Mon, 06 Feb 2017 13:26:53 -0200
In-Reply-To: <2851869.q2N89k4IqL@morokweng>
References: <20170131125429.14303-1-jack@suse.cz> <2851869.q2N89k4IqL@morokweng>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1790906.I1Z25HtRf4@morokweng>
List-ID: <linux-block@vger.kernel.org>

Am Montag, 6. Februar 2017, 12:48:42 BRST schrieb Thiago Jung Bauermann:
> 216 static inline void wb_get(struct bdi_writeback *wb)
> 217 {
> 218         if (wb != &wb->bdi->wb)
> 219                 percpu_ref_get(&wb->refcnt);
> 220 }
> 
> So it looks like wb->bdi is NULL.

Sorry, looking a little deeper, it's actually wb which is NULL:

./include/linux/backing-dev.h:
371             return inode->i_wb;
   0xc00000000037999c <+76>:    ld      r31,256(r29)

./include/linux/backing-dev-defs.h:
218             if (wb != &wb->bdi->wb)
   0xc0000000003799a0 <+80>:    ld      r9,0(r31)
   0xc0000000003799a4 <+84>:    addi    r9,r9,88
   0xc0000000003799a8 <+88>:    cmpld   cr7,r31,r9
   0xc0000000003799ac <+92>:    beq     cr7,0xc0000000003799e0 
<locked_inode_to_wb_and_lock_list+144>

We can see above that inode->i_wb is in r31, and the machine crashed at 
0xc0000000003799a0 so it was trying to dereference wb and crashed.
r31 is NULL in the crash information.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
