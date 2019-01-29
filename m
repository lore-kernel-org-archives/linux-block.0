Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA5C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 13:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AA721841
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 13:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="knGJb/Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfA2NfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:35:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40631 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfA2NfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so8750593pgp.7
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DIKcQYIMkLJVpJVsd4tCDAAhgYeZCb4MGca5YKCbwzM=;
        b=knGJb/HfFtiYDeP9nhHwTdX16wPD0wLGG89ZOtjbOcB+QGEE6RZS0CCX3ONTK5LqOe
         QUqQgOYklr1t3RLO+/u6cphW6nGUIlfAdXGonhewrXZhxvgaEyOGkMnTG2a1mjIPZGBc
         GvkgfWzS1FDwI/qi+/pfNWdUQCxCWttM/R4hCAo6y0FcGOjH+DC6oIOHmGjYQvFdFfTH
         EZvvMx5wTGkSTRmBpAUbQSPo58Za5DQPGD6u3fUr9th49AJAolED/TLDUPOHlzsRPEUC
         rytauij3XN3H0+KInH3kkZpVoN/Nz2ykbHUyXOyYvQMY6BcdXkpotjy+pFwpp04JZJ2K
         766A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DIKcQYIMkLJVpJVsd4tCDAAhgYeZCb4MGca5YKCbwzM=;
        b=aOgx+7E88SvQurfAX+gTEm7oAUPZoQf0SxGSh+pd1Cxb3Hs/VRUwUPLTfZ+8XMHbwa
         fjrxotWpeKkvgtur3YJRpo/e5y9ED7Ebwzh9dFNPGLgL0tzLiarOnQRPrTO8ELHYTxsn
         Me68DHRVXZtuvo2f11jfdcw69uI9/cAXjwDoVCeOQrHuaR5zk9JoarsA6BnovC+AdunH
         mG2Vz6PeudLRUqdYLS/XiBEQcnx8g54sFNMjUzxwBDCIngFWEVtrDeoRfv3KgiChCi2Z
         HKNLv1XL5nKTbY2nK+O75IsMR8UwG/i+ZzmOIdzB5YDSt+yvtNi8lsWkRr5YbwyVH82p
         IXaQ==
X-Gm-Message-State: AJcUukcvKo+Vmzl0TOpG0BwLnbKMU/ov028uS65ykHjm22TQZwvEJw9S
        qYj5TSjLYdmfRgPtQGEsIfsd42Bauj4=
X-Google-Smtp-Source: ALg8bN4ngIjnj6RNIYlC+/7l84RrGSf64Re8XodizzIQsGuSuxBSB5p4bfYFikx8bVw3cefSdcMFMA==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr23180303pgk.102.1548768906884;
        Tue, 29 Jan 2019 05:35:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b202sm53998306pfb.88.2019.01.29.05.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:05 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org, hch@lst.de,
        jmoyer@redhat.com, avi@scylladb.com
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <87tvhrpsqg.fsf@oldenburg2.str.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74fd3127-75f1-3a48-d3cb-a8f6c9bd0b74@kernel.dk>
Date:   Tue, 29 Jan 2019 06:35:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87tvhrpsqg.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 5:12 AM, Florian Weimer wrote:
> * Jens Axboe:
> 
>> +#define IORING_MAX_ENTRIES	4096
> 
> Where does this constant come from?  Should it really be exposed to
> userspace?

Seems pretty handy for the application to know what the limit is?

>> +struct io_uring_params {
>> +	__u32 sq_entries;
>> +	__u32 cq_entries;
>> +	__u32 flags;
>> +	__u16 resv[10];
>> +	struct io_sqring_offsets sq_off;
>> +	struct io_cqring_offsets cq_off;
>> +};
> 
>> +struct io_sqring_offsets {
>> +	__u32 head;
>> +	__u32 tail;
>> +	__u32 ring_mask;
>> +	__u32 ring_entries;
>> +	__u32 flags;
>> +	__u32 dropped;
>> +	__u32 array;
>> +	__u32 resv[3];
>> +};
>> +
>> +struct io_cqring_offsets {
>> +	__u32 head;
>> +	__u32 tail;
>> +	__u32 ring_mask;
>> +	__u32 ring_entries;
>> +	__u32 overflow;
>> +	__u32 cqes;
>> +	__u32 resv[4];
>> +};
> 
> Should the reserved fields include a __u64 member, to increase struct
> alignment on architectures that might need it in the future?

Sure, I can do that.

>> +#define IORING_ENTER_GETEVENTS	(1 << 0)
> 
> Should this be unsigned, to match the u32 flags argument?  (Otherwise
> using 32 flags can be difficult).

Good point, I've changed them all to be unsigned.


-- 
Jens Axboe

