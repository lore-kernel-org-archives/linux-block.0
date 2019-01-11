Return-Path: <SRS0=DRnZ=PT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B0FC43387
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7F020872
	for <linux-block@archiver.kernel.org>; Fri, 11 Jan 2019 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YaRRhW4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfAKSep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:34:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43361 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbfAKSep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Jan 2019 13:34:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so7323411pfk.10
        for <linux-block@vger.kernel.org>; Fri, 11 Jan 2019 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lszYkSIu7S0G0GkbSWA6G+IUU99PAcTok/8iYuS+0Ig=;
        b=YaRRhW4r0sXDl899rnnW0bmtsUu+0KKxCP0jj2tRzDrR0dusN6rJEBnDBw4WhY28Ph
         deJyTcNTtTuSVoPZbVLfyFyftncmg5WG/TGIfCwSy/WnR/w4qFbhv5ABKq0HKrpDykud
         LncFXcN00wus7FWpzGxANj1xB+GiTiAWNtikIP6kBLUxXpanH/2DtKG1U+r6znZQlIV2
         yhyvAzSfoGrvMMPXWSKeyhB21q9S0VZcPCvUqavsvvJDbaSOAH+nIH14ZZvcKFKExxmw
         jOc/Tz3KllhN3w8diLSnCnyI2OkizfiNFFbAl3UoxSEag8mUZnBmOpFN8NQ0NyS2fU24
         M0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lszYkSIu7S0G0GkbSWA6G+IUU99PAcTok/8iYuS+0Ig=;
        b=lzVOlchAHy2RaveMgtp4BR4pEiDvo2Q6P7h23eu856uGQs8EwtkNfh0q0v8RGL66bD
         KUDVV0KyRqvzKGpibYJZUjb/l5qFLVlZCDbb5Jc1Yn3hdWZX/cCoNbN3CxtRlsGtdbfb
         DizX60/GLrTjteatqK5ZRpj50hcEyxT/CxWBSw1rmCzJ08YHpPXM8FeoHPNkvyEpU6u+
         TWJOWk3iuJDekgz2dDMQ9N1mR6QazS5sgvj3TYTXH2mDzfWODK3ZTfmffxO3aRTG8dUj
         3OD3Zc5FAVGhFTp9BVH99/kkzhBA2Mh7j4i3fYDIyCVTIKFMqcXdIrY3SRrodXcPlSKo
         dW1Q==
X-Gm-Message-State: AJcUukcipX7lHJ9ABPMo3Nd4Qe2KxayHYCjizSYicwHxc6I0QIp9NPPN
        UxGm633ikSyaVl8Xn2LhTgnspA==
X-Google-Smtp-Source: ALg8bN6xID5YBAtKrZY68YrPvVJLAiahon10dfUNpDL3hYzG5nv9ljX9bXqwuVpp0uDT7xWsDYs+Eg==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr14048409pgs.73.1547231684220;
        Fri, 11 Jan 2019 10:34:44 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1250? ([2620:10d:c090:180::1:fab8])
        by smtp.gmail.com with ESMTPSA id k191sm92447325pgd.9.2019.01.11.10.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 10:34:42 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-6-axboe@kernel.dk> <yq1sgxzys3s.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f97a5b9f-68f3-c4af-649d-7dffbc35e37f@kernel.dk>
Date:   Fri, 11 Jan 2019 11:34:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <yq1sgxzys3s.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/19 11:19 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> +struct io_uring_sqe {
>> +	__u8	opcode;
>> +	__u8	flags;
>> +	__u16	ioprio;
>> +	__s32	fd;
>> +	__u64	off;
>> +	union {
>> +		void	*addr;
>> +		__u64	__pad;
>> +	};
>> +	__u32	len;
>> +	union {
>> +		__kernel_rwf_t	rw_flags;
>> +		__u32		__resv;
>> +	};
>> +};
> 
> A bit tongue in cheek and yet somewhat serious: While I'm super excited
> about the 4 x 64 bitness of the sqe, where does the integrity buffer go?
> Or the 128-bit KV store key. How do we extend this interface beyond the
> flags?

For integrity buffers, how about we stash them on the side? The newer
series has an extra system call, io_uring_register(), which is currently
used for registering files and buffers for IO on the side. You could
trivially tie an integrity buffer to an sqe through that.

For KV, I thint that's an actually interesting use case (sorry,
integrity), and we might just want to bite the bullet and extend the sqe
to full 64 bytes.  We're currently at 48 bytes, which leaves us with 16
bytes of space for KV, and other use cases.

-- 
Jens Axboe

