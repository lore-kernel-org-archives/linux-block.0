Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DD7C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14532217AB
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0SVOpsKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfK1RGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:06:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45333 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfK1RGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 12:06:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so13384550pfn.12
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2019 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1imsgxsl3ywnARWtQwBa3rbLqViODjeJtSs8fpqWLOk=;
        b=0SVOpsKF/rm6XOc9rX2WI5ruSf8tRL3Y1ZBPEpoDH121sJ7yEBCx2gCLNFJkFV0uBu
         c7HOzlWp632OvavPVroeULxKs5eb4pJhXC9ZsjHzqXUcFDvohNcHEyAaHqKdI0bLWgLV
         fzG2W7VlcMpPg/ByPMsY7oMNI8BcnHKelIzWd26cs+AjNMmVzKNkY8IMa9/oGHbIa328
         z/U8bwCZGdU9x1eJoQJsq1406Tw2iarHo7x+W9+C4SoIhrrQhNF0HFS0KBezBOorToT1
         Ou+lOn9YfT/+ApWec9gVECHa0Li4bKX6b8lk1548Lrl3d3Ze5FBf5j5zZXdB+okS5azd
         Tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1imsgxsl3ywnARWtQwBa3rbLqViODjeJtSs8fpqWLOk=;
        b=AJh8ibJdfcm6xRKzaDm4kSjgG4aUvOu2Wub8xCYtirmopgQ2J3d7SCeNxNoplYs9+t
         7/Jc9bQpidkVaw1oS2ua/BIu0k5geSrIwphdkdsk40PAOEMdX7Q8haBo78tS7/90ZgDG
         P7hL0R28x7KkOHxVj14UwDTZYJARe8Uki49EXThVOjWfhZ+GNNyQO0feH8lw56VpAYX+
         Y6GAXLLvDm0hV1wTd39//8ZExiFrUUZcpQotmyEF7++1F+N1DnwLecg9Aw7eBeIcVmd9
         WUrRewv25SYh+KQrqd6F/g/atj03RbLdnRXKMOrMVhetPN6rm3CdbxrcipRvdwu/xnNr
         WP9g==
X-Gm-Message-State: APjAAAUyi/9TZDBO4YV6fDu6ppot0Vt8eHMt045l9tPlGbEITms0Ydyz
        7Jn0BKMztsmakPrANwxBYA/2QQ==
X-Google-Smtp-Source: APXvYqw/ndjuCJGaOPR8gE8No2mNqL89C3zaSA4+ynOYaSPZVMH93zSCpG1tJ1c9U/h04d3eKbyrGg==
X-Received: by 2002:a63:4466:: with SMTP id t38mr12323393pgk.316.1574960790649;
        Thu, 28 Nov 2019 09:06:30 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:a930:60a8:686e:252a? ([2605:e000:100e:8c61:a930:60a8:686e:252a])
        by smtp.gmail.com with ESMTPSA id a12sm21286896pfk.188.2019.11.28.09.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:06:29 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: add mapping support for NOMMU archs
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20191128115322.416956-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0371ebda-9ec7-e3fc-3d80-3160e84aa283@kernel.dk>
Date:   Thu, 28 Nov 2019 09:06:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191128115322.416956-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/19 3:53 AM, Roman Penyaev wrote:
> That is a bit weird scenario but I find it interesting to run fio loads
> using LKL linux, where MMU is disabled.  Probably other real archs which
> run uClinux can also benefit from this patch.

Not that weird I think, and looks fine to me. I'll queue it up for 5.5,
thanks.

-- 
Jens Axboe

