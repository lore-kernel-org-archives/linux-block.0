Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+rb3WJH"
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085510F9
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 07:40:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cda22140f2so2152384b3a.1
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 07:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701445202; x=1702050002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G9oaS+0gU261k2uWs6spLStzxvx1k70fRoFnE2M4u0w=;
        b=d+rb3WJHGym2pFkD/wN2sbhxQOBcbW1qBemgTnA61+mLn46/Gti4Nkr0o6a0Xi4S5Y
         ACsq3Lmq0BTUQQTjLAkCfAClmWtgVI7ULrvcBgwR5gB2+4vK88RZ8ex13zgaH5SQIfg7
         mOXBJwvyshDYy0tRqBfhqgLQRYp7GFTwejWbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445202; x=1702050002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9oaS+0gU261k2uWs6spLStzxvx1k70fRoFnE2M4u0w=;
        b=grng3yvWIpK2dy+YbU2dapMTt9TGL932e77RN2wW3l8PkJ1AvKG+8XFrEfufwelL73
         rTSeXow0nuL3uLqZujYHRXqoDLDO+hW9oUcSvu8uRimlvcovzAmOaqhtErJWlYW0San/
         CKvVFglfDaidpLSikIHalLczxAzUgG9zAkecNzANI9FgxLLEAvx6W+RMijfW1GuG4uCa
         qQHJVx4SMjP+/vPncgyFt8PVujfKhW3U8/SFMv01FDZuLxFQUhlOi/TazcFLFA3rgbpo
         BuBKm3em3wwtwUfP+q+tB142kxrQ6oaAWzd60rXSmjsyxw6CHnjKvx9jUyy3mvo9XrNF
         J2iA==
X-Gm-Message-State: AOJu0YzEI70sYjgNLfzBABXAAieLbI9WrDKf9XrriZ5+iGCbQHMbVaI0
	bg7O4Svp1nvJhbtavtrluARmdw==
X-Google-Smtp-Source: AGHT+IGhQn5UrTUK1szrIeIHpzJcwNpeIds1j1OPt871QrmLHqC1ZmzkZIOjVP/UYeskS09TpMTlnQ==
X-Received: by 2002:a05:6a20:918e:b0:18b:8dfa:8895 with SMTP id v14-20020a056a20918e00b0018b8dfa8895mr31246058pzd.17.1701445202091;
        Fri, 01 Dec 2023 07:40:02 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79e50000000b006c69820065bsm3238369pfq.176.2023.12.01.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:40:01 -0800 (PST)
Date: Sat, 2 Dec 2023 00:39:56 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Dongyun Liu <dongyun.liu3@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	lincheng.yang@transsion.com, jiajun.ling@transsion.com,
	ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
Message-ID: <20231201153956.GB404241@google.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130152047.200169-1-dongyun.liu@transsion.com>

On (23/11/30 23:20), Dongyun Liu wrote:
> INFO: task init:331 blocked for more than 120 seconds.  "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:init   state:D stack:    0 pid:    1 ppid:     0 flags:0x04000000
> Call trace:
>   __switch_to+0x244/0x4e4
>   __schedule+0x5bc/0xc48
>   schedule+0x80/0x164
>   rwsem_down_read_slowpath+0x4fc/0xf9c
>   __down_read+0x140/0x188
>   down_read+0x14/0x24
>   try_wakeup_wbd_thread+0x78/0x1ec [zram]
>   __zram_bvec_write+0x720/0x878 [zram]
>   zram_bvec_rw+0xa8/0x234 [zram]
>   zram_submit_bio+0x16c/0x268 [zram]
>   submit_bio_noacct+0x128/0x3c8
>   submit_bio+0x1cc/0x3d0
>   __swap_writepage+0x5c4/0xd4c
>   swap_writepage+0x130/0x158
>   pageout+0x1f4/0x478
>   shrink_page_list+0x9b4/0x1eb8
>   shrink_inactive_list+0x2f4/0xaa8
>   shrink_lruvec+0x184/0x340
>   shrink_node_memcgs+0x84/0x3a0
>   shrink_node+0x2c4/0x6c4
>   shrink_zones+0x16c/0x29c
>   do_try_to_free_pages+0xe4/0x2b4
>   try_to_free_pages+0x388/0x7b4
>   __alloc_pages_direct_reclaim+0x88/0x278
>   __alloc_pages_slowpath+0x4ec/0xf6c
>   __alloc_pages_nodemask+0x1f4/0x3dc
>   kmalloc_order+0x54/0x338
>   kmalloc_order_trace+0x34/0x1bc
>   __kmalloc+0x5e8/0x9c0
>   kvmalloc_node+0xa8/0x264
>   backing_dev_store+0x1a4/0x818 [zram]
>   dev_attr_store+0x38/0x8c
>   sysfs_kf_write+0x64/0xc4

Hmm, I'm not really following this backtrace. Backing device
configuration is only possible on un-initialized zram device.
If it's uninitialized, then why is it being used for swapout
later in the call stack?
