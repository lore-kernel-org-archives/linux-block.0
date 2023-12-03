Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DJMTVqnd"
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096C1C1
	for <linux-block@vger.kernel.org>; Sat,  2 Dec 2023 17:23:33 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b2e330033fso1530372b6e.3
        for <linux-block@vger.kernel.org>; Sat, 02 Dec 2023 17:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701566612; x=1702171412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0SBtkIv3cee5FCWIhTFG7QQThNZLcxG9WCJ+X1Q6Kk=;
        b=DJMTVqndOCUNIhMrzdK1D1JRLuZj7IwtgGfCZSbwrFKPHhxTWvhuI2eAQIa/TfcWwr
         sx5N/fb1qQqAxKbtgJ9h3Z8gVJV/yf9GBRPeBlTTysYB1nnhmwys2BwwdRuhO124Mq6k
         FdNOUv4A1Ypsg+5ZkAFm4V/K6IjolxR8ng+og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701566612; x=1702171412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0SBtkIv3cee5FCWIhTFG7QQThNZLcxG9WCJ+X1Q6Kk=;
        b=Dpv0lIoGJWqxb4KUGUFoHyspFi1eNdXnKN2J8FdoQBmZ0ID90uUuEuFGnvVMwQmMCV
         p2gVcHSKl4z/Pnri9/P9ifrHM9lhKPqHW4yn8bAn9qpH8sMLDHWe+Grx7uEDFWvBJWbE
         ipcrJ6+zj2Msf6A4bNEs4h0P/E5vJSFu+uFRr3oDTGDeF0kgzRYAglFr3zVSjQLmAM/N
         mijavgJW+DTxWdyG9249ps4yLKYCBBsp0hdctnvNCZb5Q2mYTh7h2mPiUF58hsjG16Wa
         xHlntWhRrkfj9reX97GK6uZRK3ovsUIISj16u3VPNDef8px2H45+iiqjtygWngoV9nIb
         5Olw==
X-Gm-Message-State: AOJu0YwErp9lH7o34BBWLrkNtst8jN6tDzmCwktBbiZn/RuKc0/ePAKU
	J8TbeRemWLwlBYQlyYbnxSC7Mg==
X-Google-Smtp-Source: AGHT+IHC2toBcuBeNWxKismMtpL/a3/skNmR//TaMD8W8MvvGnoM4nk06NkJjkuCi3orZjPAv1p3zA==
X-Received: by 2002:a05:6808:2e95:b0:3a9:9bb6:811 with SMTP id gt21-20020a0568082e9500b003a99bb60811mr2822958oib.57.1701566612331;
        Sat, 02 Dec 2023 17:23:32 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id z123-20020a636581000000b005b458aa0541sm5208325pgb.15.2023.12.02.17.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 17:23:31 -0800 (PST)
Date: Sun, 3 Dec 2023 10:23:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dongyun Liu <dongyun.liu3@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org,
	axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, lincheng.yang@transsion.com,
	jiajun.ling@transsion.com, ldys2014@foxmail.com,
	Dongyun Liu <dongyun.liu@transsion.com>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
Message-ID: <20231203012326.GE404241@google.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
 <20231201153956.GB404241@google.com>
 <b49d6a29-e3a3-4b6b-8892-8ded319b2619@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49d6a29-e3a3-4b6b-8892-8ded319b2619@gmail.com>

On (23/12/02 23:50), Dongyun Liu wrote:
> On 2023/12/1 23:39, Sergey Senozhatsky wrote:
> > On (23/11/30 23:20), Dongyun Liu wrote:
> > > INFO: task init:331 blocked for more than 120 seconds.  "echo 0 >
> > > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > task:init   state:D stack:    0 pid:    1 ppid:     0 flags:0x04000000
> > > Call trace:
> > >    __switch_to+0x244/0x4e4
> > >    __schedule+0x5bc/0xc48
> > >    schedule+0x80/0x164
> > >    rwsem_down_read_slowpath+0x4fc/0xf9c
> > >    __down_read+0x140/0x188
> > >    down_read+0x14/0x24
> > >    try_wakeup_wbd_thread+0x78/0x1ec [zram]
> > >    __zram_bvec_write+0x720/0x878 [zram]
> > >    zram_bvec_rw+0xa8/0x234 [zram]
> > >    zram_submit_bio+0x16c/0x268 [zram]
> > >    submit_bio_noacct+0x128/0x3c8
> > >    submit_bio+0x1cc/0x3d0
> > >    __swap_writepage+0x5c4/0xd4c
> > >    swap_writepage+0x130/0x158
> > >    pageout+0x1f4/0x478
> > >    shrink_page_list+0x9b4/0x1eb8
> > >    shrink_inactive_list+0x2f4/0xaa8
> > >    shrink_lruvec+0x184/0x340
> > >    shrink_node_memcgs+0x84/0x3a0
> > >    shrink_node+0x2c4/0x6c4
> > >    shrink_zones+0x16c/0x29c
> > >    do_try_to_free_pages+0xe4/0x2b4
> > >    try_to_free_pages+0x388/0x7b4
> > >    __alloc_pages_direct_reclaim+0x88/0x278
> > >    __alloc_pages_slowpath+0x4ec/0xf6c
> > >    __alloc_pages_nodemask+0x1f4/0x3dc
> > >    kmalloc_order+0x54/0x338
> > >    kmalloc_order_trace+0x34/0x1bc
> > >    __kmalloc+0x5e8/0x9c0
> > >    kvmalloc_node+0xa8/0x264
> > >    backing_dev_store+0x1a4/0x818 [zram]
> > >    dev_attr_store+0x38/0x8c
> > >    sysfs_kf_write+0x64/0xc4
> > 
> > Hmm, I'm not really following this backtrace. Backing device
> > configuration is only possible on un-initialized zram device.
> > If it's uninitialized, then why is it being used for swapout
> > later in the call stack?
> 
> Uh, at this moment, zram has finished initializing and is
> working. The backing device is an optional zram-based feature.
> I think it can be created later.

backing_dev_store() can't be called on an initialized device,
that's what init_done() at the very beginning of backing_dev_store()
is supposed to ensure:

...
	down_write(&zram->init_lock);
	if (init_done(zram)) {
		pr_info("Can't setup backing device for initialized device\n");
		err = -EBUSY;
		goto out;
	}
...
