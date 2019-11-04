Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBCCA9EB5
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310B321D7D
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 14:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ac2VFPVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfKDOMH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:12:07 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38311 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfKDOMH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 09:12:07 -0500
Received: by mail-il1-f193.google.com with SMTP id y5so14910335ilb.5
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 06:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DR+oWiPjQegZyZI6vFdD2LpXMOa5Nf5eBLCq5dbguTM=;
        b=ac2VFPVmIMBe7g0t275TztnT6IstGtn+s+uwdk82KIBR8Be6FA1DteUBPpsI80ZtSN
         wJlCk1EyRRzFqTF5f1KBjIgxGBKROGOws5cg4qSGERHRmIfceX/1kLRFwZ52AqwmQWiu
         OgWNc8qWdV8dVUDTZ1nj/SZ/5NFupwAlPl6a9k33Dcum10KERpHCKLxtbXxmHupA8Z0K
         DLM0Y5CdRWEzsapEfsmzbKViW6eKKKPp4zamJc887SjL4sDtKu80zOb0opwnaC72Odx1
         nkncDXdXhweRh+CuL1YayQ+RpeRozE9o9FgYB2EK6ABeUnntsSca00Ocwwhy7NeHlVqe
         T7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DR+oWiPjQegZyZI6vFdD2LpXMOa5Nf5eBLCq5dbguTM=;
        b=GoQ89cmndD5g8ECeGEIyUERmfaUDv1UwSmTGtqoSoRydd/udmPPZCvUUO0IWHNG2Ws
         aD7wtnvyN+ZYnaYElfsCr+oPZMDNihx5z2bBVFbwWUPEW098uBtKUsa6OpBkkLehBqBU
         f9uhQxs7TGYW6LXwy8VO+JPV+aP7Koq7gYyo25CPqQPFZrI4fKU8JiAM7ANW8xaLv1GT
         Y3Lltvewzxw6hASEJwLWEb5mggNxQq/jn6IiH7jxTUN24BALDwPZ+INsN78oi1dVYpd6
         Z54xFx2B63sezZTlDXHXN+3N7pd3rbAlC1nK+Q3zgev9d/keczkPQdR43Qjs0QBgunOm
         A88Q==
X-Gm-Message-State: APjAAAWbbLEksJBm4UICCTMYSwsoyAr9J2lnaLPZPi9G9cOQvwSFm8J1
        o8YKspgvP1a1j7sXzMp/tRMp2g==
X-Google-Smtp-Source: APXvYqwUt2MMHG1D+EmHsgflQ1nYyxVvB+sxbcZjvmCHsH88CdBI3hR1zCSpdeksqEH05JfCaywl0Q==
X-Received: by 2002:a92:8703:: with SMTP id m3mr29373393ild.131.1572876726451;
        Mon, 04 Nov 2019 06:12:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l3sm1624820ioq.68.2019.11.04.06.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 06:12:05 -0800 (PST)
Subject: Re: [PATCH v3 0/3] block: sed-opal: Generic Read/Write Opal Tables
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Jonas Rabenstine <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
References: <20191031161322.16624-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d354e2bd-6639-9022-2bbd-e54657849c0f@kernel.dk>
Date:   Mon, 4 Nov 2019 07:12:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031161322.16624-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/19 10:13 AM, Revanth Rajashekar wrote:
> This series of patches aims at extending SED Opal support:
> 1. Generalizing write data to any opal table
> 2. Add an IOCTL for reading/writing any Opal Table with Admin-1 authority
> 3. Introduce Opal Datastore UID, which can be accessed using above ioctl
> 
> Datastore feature described in:
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set-Additional_DataStore_Tables_v1_00_r1_00_Final.pdf
> 
> Opal Application Note:
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Opal_SSC_Application_Note_1-00_1-00-Final.pdf
> 
> This feature has been successfully tested on OPAL Datastore and MBR table using
> internal tools with an Intel SSD and an Intel Optane.
> 
> Changes from v2:
> 	1. Drop a patch which exposes UIDs in UAPI.
> 	2. Fix coding styles wherever required based on LKML feedbacks.
> 	3. Eliminate a few redundant assignments in the code.
> 	4. Add a break under copy_from_user error condition in
>             generic_table_write_data func.
> 	5. A few refactoring/cleanups in both the patches.
> 	6. Introduce a new patch which introduces Opal Datastore table UID.
> 
> Changes from v1:
> 	1. Fix the spelling mistake in the commit message.
> 	2. Introduce a length check condition before Copy To User in
>             opal_read_table function to facilitate user with easy debugging.
> 	3. Introduce switch cases in the opal_generic_read_write_table ioctl
>             function.
> 	4. Move read/write table opal_step to discrete functions to reduce the
>             load on the ioctl function.
> 	5. Introduce 'opal table operations' enumeration in uapi.
> 	6. Remove tabs before the #defines in opal_read_write_table structure
>             to improve the code readability.
> 	7. Drop a patch which exposes UIDs in UAPI.
> 	8. Eliminate a few redundant assignments in the code.
> 	9. Add a break under copy_from_user error condition in
>             generic_table_write_data func.
> 	10. A few refactoring/cleanups in both the patches
> 	11. Introduce a new patch which introduces Opal Datastore table UID.

Applied for 5.5, thanks.

-- 
Jens Axboe

