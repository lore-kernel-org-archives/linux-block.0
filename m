Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C9191
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268078; cv=none; b=BHqREW+JxXc2EnSkYghUEgYMhof8wm4GX+sjXFWWde8i50S82OvpLo+adAGuPcNEqSmyxfO2tex0pVjOa+wFqqTDbyX0R0LEKydDc9JsaZZTyUnDPbYLtxJIxK7FLTSQmbBirwhD4/5UugXaLWx2g8E/O0lu/9npprLUAWjK7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268078; c=relaxed/simple;
	bh=quYQ44lNL28NGsGxFsC3r6wlm1Y7jznRiSlxIni8Rlc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dtoTJB8t9XTX+pNNMlKnMJuDtkaVMxv+egKDkhLi8qTVzqpzf+ZK1g+7FrDCflt5mzTueHT2qyYw9sH4lOAP2+3wgYjZGZ818F5K23/WUKMqj6lUrHUjK1f9A+NJXx40Jtiem1rgISct26YXKIr7m7G5cIByn4FeNMa7HQcmsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICIVapwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICIVapwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747268074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNzHUEUeO2dhjTSVzvgUR5Z+U81BlGK7DOEGqJYrY1c=;
	b=ICIVapwT+ltb/ndbQX4pHJikd3vnPZvfsaSJrlAUwZNwyBEIyFnMjwaJfuv4NtXrjUyn5N
	BlW7XCgIGshn3CQAA9JgAqtMxE1mdMrDLDnGsG0gc9iBCwryvsbIk5vi7jzPb+z7CgnG7d
	KLTqH0DxGlZcEneuCR95/+UAdaOW7pw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Z4tWkiRSMvOlK3JZJTMIiw-1; Wed, 14 May 2025 20:14:33 -0400
X-MC-Unique: Z4tWkiRSMvOlK3JZJTMIiw-1
X-Mimecast-MFC-AGG-ID: Z4tWkiRSMvOlK3JZJTMIiw_1747268072
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f6e59df2f3so8090646d6.3
        for <linux-block@vger.kernel.org>; Wed, 14 May 2025 17:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268072; x=1747872872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNzHUEUeO2dhjTSVzvgUR5Z+U81BlGK7DOEGqJYrY1c=;
        b=HkCwOZoAZOTCW9erl/YxY9WBE1Z1ltPihIexrdHZgNz4AXIc88tyCSw0zHrXcyZ2zO
         2Yip792PP9Z5ppgLR+i+WU/vrtq8jofHyj10fcVQ2Xz520MNJ/M/RgkL+2XQfTvgnszm
         hdbdrwnHQLBNn6i4QRQNpCfwYEMoQL56QLEVJplLXfETW5ThnF+E1Af5y/5sCPmnDo2n
         XikOEbq28Up8fkdrQoEFAxarm1fmMyxSia2ihdR0E0ebpT3sD9f7mrMdWrVg1CI86Rvn
         WiXlVd6aOOthW/SP7kiKhl3vOa3O89+PJdJEIWey/tIQzMsGb/PK6AvhKakenDJ/Tqz+
         NGEw==
X-Forwarded-Encrypted: i=1; AJvYcCVXKSgFKSD3FvDYybNF6PDmItzhqq0GH+A3LiYFGPCynxeQOiuIo7NKPkCt6eY9P8YOcmdWb+1LjkBj5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vKyy5yI8pbwVCVPOChY2V7IYY76mCVY0jQ1iVsHux/6XMQts
	c+xjoBxKFUQjSWDOvqv5M44Ua+TyMHWBEGaZtvLbOMI7LVg0EG7rCsUddOyUY3En+J+1tZ/akpF
	Nwe3/qq2NbWrOLIOjcsZl9YmerBF3o/Fy1L7vmFeHdR7QGPQ3lcITq1Jj5jP5
X-Gm-Gg: ASbGncvpuzVYrdqavK6R5Hse6BBvoT4a/ZrKCMiQi2ImPVZ+aZpsQ21GrEE9L15xbq0
	EyRDqDSC4sCKtY6kHqeu/UvxJQnLlKPytQKOdcFxSmep2Lj9RQvaSz5ccf3ifbbbaOWRzWQKFrB
	3Y5EsEt7s4cZKb2gEHQKc8g80iC2Ha5eVQ1oED7NzfAxe+yhtuwCp164dw7T4SsfNi2ltb+jTYp
	VwX1BMToAa8dIQy9kM7ZwXjDN4fe7pniODtDUP7HmTc7gqzUV8EShirio9fJiQI8QUXQAABLE+K
	6zqTGe3XL1tp11bbpme6bwo3wz379JyOGubRDu1EVXoQJeuLw3Vf0F0V9Q==
X-Received: by 2002:a05:6214:d0c:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-6f896ea9057mr99475006d6.31.1747268072562;
        Wed, 14 May 2025 17:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsr7IFrS3iOvG8LAJsmK3Z9rLV7eHpX1e12kq9yRd9jWKqc02gH6HkR1aDUM2ojcwgcm4bmg==
X-Received: by 2002:a05:6214:d0c:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-6f896ea9057mr99474556d6.31.1747268072185;
        Wed, 14 May 2025 17:14:32 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39e0c8csm87119136d6.18.2025.05.14.17.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 17:14:31 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5f412ff9-c6a3-4eb1-9c02-44d7c493327d@redhat.com>
Date: Wed, 14 May 2025 20:14:26 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 01/43] llist: move llist_{head,node} definition to
 types.h
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
 rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
 daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com,
 tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
 sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
 max.byungchul.park@gmail.com, boqun.feng@gmail.com, yskelg@gmail.com,
 yunseong.kim@ericsson.com, yeoreum.yun@arm.com, netdev@vger.kernel.org,
 matthew.brost@intel.com, her0gyugyu@gmail.com
References: <20250513100730.12664-1-byungchul@sk.com>
 <20250513100730.12664-2-byungchul@sk.com>
Content-Language: en-US
In-Reply-To: <20250513100730.12664-2-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/25 6:06 AM, Byungchul Park wrote:
> llist_head and llist_node can be used by very primitives. For example,

I suppose you mean "every primitives". Right? However, the term 
"primitive" may sound strange. Maybe just saying that it is used by some 
other header files.

Cheers,
Longman

> dept for tracking dependencies uses llist in its header. To avoid header
> dependency, move those to types.h.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>   include/linux/llist.h | 8 --------
>   include/linux/types.h | 8 ++++++++
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 2c982ff7475a..3ac071857612 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -53,14 +53,6 @@
>   #include <linux/stddef.h>
>   #include <linux/types.h>
>   
> -struct llist_head {
> -	struct llist_node *first;
> -};
> -
> -struct llist_node {
> -	struct llist_node *next;
> -};
> -
>   #define LLIST_HEAD_INIT(name)	{ NULL }
>   #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
>   
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 49b79c8bb1a9..c727cc2249e8 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -204,6 +204,14 @@ struct hlist_node {
>   	struct hlist_node *next, **pprev;
>   };
>   
> +struct llist_head {
> +	struct llist_node *first;
> +};
> +
> +struct llist_node {
> +	struct llist_node *next;
> +};
> +
>   struct ustat {
>   	__kernel_daddr_t	f_tfree;
>   #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE

