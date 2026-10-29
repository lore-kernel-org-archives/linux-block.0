Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793273649;
	b=1UEQWZG4GsfoZUVRocQbOKOs5O83/Qo4cDSNZ+BcjJGXpx5vk0bdsxTwMpyrRhs0NLic
	 I9vPKnJbYxHqE0yDSr/OGI7rozwuRrKe3m5MZpx/RbF360HL/GcfgNi4yDDBBkQskM8EX
	 1PupmDwFkUJ+Pv6SzXrojAGFF6YNy1gLQUOnuflUbCtEvXLhRQR0k5vHmrJG/senMREi7
	 VwrDb2M+mxElHNzlhYx+iw13Boa7Ott4vmjhOWDmOrXwen76BcNnYIm61sQyhP1WdVN8J
	 wpE18hyXtOpUcOOtSED7De5AG3NAinMoYX0AgKsi3QsR9/ntDBms+jvyA3oyIkkMKeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XQfh3k4+hDXiXsZkZk5W8DCL2xtQAoVlJOqoAo+F65o=;
	b=YyhLzGHyUhSgHL8/WKns8VZ9w7uC2dxia2g8ity8UJ32JEY2Xt1d16UXF2soSOK9aWQy
	 oLNglM0Ln+vW1BTIAdcIUIymU3EXOBb7P4g9Kgm7Fcd+UMddl49/JVo0xHnZUJhi1Y+WF
	 tqPUfulkkmnktj9DR0oi9QM2EO25ZGvCHrrvRKg3R8vNQWPCB/9ApAaxXBJCDI1SlcITP
	 liV0ldH75jE0OBiScjL0DZ0PL2yKc1YvFpnMuw1f4d5txJqtyYlf+6kuZMzavwOPmIohx
	 WQuMvjd+fvGKy2A+jGIVwTaTwbnGxQwJj27MPg3dGqk7eIRP8lOMcFPg33d3IiYeeYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3nYklJC;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F8606A320
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 11:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 824F8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X3nYklJC
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c46bd7a7345so116208366b.0
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 04:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793273647; x=1793878447; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQfh3k4+hDXiXsZkZk5W8DCL2xtQAoVlJOqoAo+F65o=;
        b=X3nYklJCuRgcCyR3xqPgdi/GXmGfpk8u8QFC2joDWlW2/DH/NWWcm+C7DyKop5p+Rf
         TGrLG0jyLkiEBO+Lyt8uZxWmUdXS8TJkqp8iCjJiJ8yJMewv9kzVRXXu1ZXrBDoo28AY
         RRHBo4Tn0Wj5QttspXhNjXDAv708sxGwsLZ674qNAAbSdqq2u2JpGeuS2QR8s5aAHi2Q
         fCewDmNPu/473lddjuqcGnCIpO1wRIgEejeQAJmbz3wfq9CO6muY+O8TSF7kjXK1gKTq
         CoXAbW15sKrpv3KpuiMlGy9shUdPJ/JPeWnyukmFT5oX26XjulUWq4zexwvtnVxnDbjt
         wSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793273647; x=1793878447;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQfh3k4+hDXiXsZkZk5W8DCL2xtQAoVlJOqoAo+F65o=;
        b=nCTAGegtTJoRU/3haO6IUCFTSuoraHlRi7rznBctW3whCOFa15gVmDdgacCLidN1SB
         aRsuzxBI/ek9BKKWOYDViNIiQ1SFXN5LOuQZ5h5ohmEPLTTNVF7NEA93QJTjuAG618Cx
         atMj2V3wTbaKz7/2YOBBE3d8r7BJcKNkTad9kAttSFmHPFc8HTDTCdNZyx1FeTDxpnHs
         xk4gWBZmRsD3zlEX6Lyp/ZrK7UiIOTkRNdtULdQZ1w8izKh63NsbBLffs1kv66cPlBfC
         EsXNAAp2BkmZNy4tQwBkndHE7PHPSutETdko7OdonXPN69Rfg1rB/rUWqILd9jEwlM6N
         qhjA==
X-Forwarded-Encrypted: i=1; AKwUvBxUJUL1hLezRW1EmGKBOxS/EBgmwiErrQkrMd79ZA/J/78h7hyd98+ALeAm2s536DalL0pC3lzFY7PR7w==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0ZtHUsj9RK8KN50dZ89j5dmH6SW6r8VsBVEtzQ2tm4jiFjlc4
	LYYcvQkFT3U45BOJ3b1CQwCVOnUJvguUM47riLkeUGn0DmREAkD1Sn1D
X-Gm-Gg: AYBFou0eI44HVg5FsO9G0OtwYc/Wl9QGHvB47fbEUvgKohPGutC2XL+poI3cIKkJaCG
	E3O6uGemd2fk/suHwHCl/mYltetDKbK36kFbiDpUpI31biSCal4Wl/A0WO4VDqHKVHpPJFB3DeH
	FdGQKlA/xySWay49pjva92H1lUYOD2R78vYBqbEcDZbbtCWLnpUN6zzLg4h1DPtmvPMcLohQtys
	sxMy36A1mNRMgYUkY1093A8pnB2g6JCtyzuaKbn7769ah/b2rSuDzvP+8XX8exfb1S30ivqvD6A
	R9ubUTCFBNA5QJuoi8aUk+YhFanNsSLtikhDbf8xmexfPRIVpa8475by57/Rolay4BzJhQ0w+Ij
	HT/1AP1SYF7jGdLFb55lXhmBuhUIfX9R0Se+pC5vP62mnBjR1OuLlkygcAFyHU0+SrFBLMtzX/0
	Ubac8WWgozixrkfnfacMjak3nIBN7KxwJd0Jq4ZXCkyULh3WIlClGi5SxsClSeUsbeHL5eqxmwP
	MsrDsy+X/Y0BLK6BKB2SuWGYe6X7Xfci9lA7Buvzep+pavdGWSLsceHtFdRDeyqVbPhuuMRP+WH
	zlWIUqq8oqeQGzzbytZD++HvCGar3yyctyG9uYqCMsueRy3prsybAEgjlzV7YGTyTu7PqiB7jSj
	VIo+mHnbKbyiteW0AzcRmYvdn0YqLSCAhrsDnlkWsP28yJVYl48L/e2PSejTDpZRVwNjHtnzLlA
	jywA==
X-Received: by 2002:a17:907:2dab:b0:c43:b0ba:485a with SMTP id a640c23a62f3a-c49d13bc47dmr187773466b.21.1793273646707;
        Thu, 29 Oct 2026 04:34:06 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48eesm33912134f8f.30.2026.10.29.04.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 04:34:05 -0700 (PDT)
Message-ID: <69f1290c-1650-4ce4-bc0f-e8a3c03a5d14@gmail.com>
Date: Thu, 29 Oct 2026 11:34:07 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] fs: support dma-buf backed direct I/O
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj1072538@gmail.com>, djwong@kernel.org, cem@kernel.org,
 brauner@kernel.org, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com
References: <20261016091919.971295-1-anuj1072538@gmail.com>
 <4649a20f-aba9-418e-987f-66f21ab24410@gmail.com>
 <20261028162900.GA22640@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261028162900.GA22640@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/26 16:29, Christoph Hellwig wrote:
> On Sun, Oct 18, 2026 at 11:18:27PM +0100, Pavel Begunkov wrote:
>>   	file_ref_t			f_ref;
>>   	/* --- cacheline 3 boundary (192 bytes) --- */
>> +
>> +	/*
>> +	 * A tag representing the underlying subsystem for dma-buf I/O.
>> +	 * See struct dma_buf_io_ctx::importer_tag.
>> +	 */
>> +	unsigned long			f_dma_io_tag;
>>   } __randomize_layout
> 
> Growing strut file into a new cacheline just for dmabufs is a no-go..

I didn't check last time but there is space to spare. Maybe I don't
know about all production enabled options growing mutexes.

struct file {
         spinlock_t                 f_lock __attribute__((__aligned__(4))); /*     0     4 */
         fmode_t                    f_mode;               /*     4     4 */
         const struct file_operations  * f_op;            /*     8     8 */
         struct address_space *     f_mapping;            /*    16     8 */
         void *                     private_data;         /*    24     8 */
         struct inode *             f_inode;              /*    32     8 */
         unsigned int               f_flags;              /*    40     4 */
         unsigned int               f_iocb_flags;         /*    44     4 */
         const struct cred  *       f_cred;               /*    48     8 */
         struct fown_struct *       f_owner;              /*    56     8 */
         /* --- cacheline 1 boundary (64 bytes) --- */
         union {
                 const struct path  f_path;               /*    64    16 */
                 struct path        __f_path;             /*    64    16 */
         };                                               /*    64    16 */
         union {
                 struct mutex       f_pos_lock __attribute__((__aligned__(8))); /*    80    24 */
                 u64                f_pipe;               /*    80     8 */
         } __attribute__((__aligned__(8)));               /*    80    24 */
         loff_t                     f_pos;                /*   104     8 */
         void *                     f_security;           /*   112     8 */
         errseq_t                   f_wb_err;             /*   120     4 */
         errseq_t                   f_sb_err;             /*   124     4 */
         /* --- cacheline 2 boundary (128 bytes) --- */
         struct hlist_head *        f_ep;                 /*   128     8 */
         union {
                 struct callback_head f_task_work __attribute__((__aligned__(8))); /*   136    16 */
                 struct llist_node  f_llist;              /*   136     8 */
                 struct file_ra_state f_ra;               /*   136    32 */
                 freeptr_t          f_freeptr;            /*   136     8 */
         } __attribute__((__aligned__(8)));               /*   136    32 */
         file_ref_t                 f_ref;                /*   168     8 */

         /* size: 176, cachelines: 3, members: 19 */
         /* forced alignments: 3 */
         /* last cacheline: 48 bytes */
} __attribute__((__aligned__(8)));

  
> Also note that a file can be placed on multiple block devices when
> using RAID or just btrfs placements (not sure about f2fs).

Filesystems should set it to a super block or something similar.
It's "unsigned long" for that exact reason. Shouldn't be a problem
for md either.

-- 
Pavel Begunkov

