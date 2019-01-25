Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E83EC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 04:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3AC21872
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 04:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfAYEFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:05:08 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35554 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfAYEFI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 23:05:08 -0500
Received: by mail-pg1-f181.google.com with SMTP id s198so3644677pgs.2
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 20:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anUl9QitWLG5cv/cgGLMAtDx3OId3zydUVFxrJZrol8=;
        b=PviouP3ireHA1F3OYGT8JpWpGY5861FwHXaBsHPnjMnKLwmdGKzy4TZd4aGuI+3gGE
         DE/oKLWonIeDDOy7qWwt0HwOjD6nhQFhQFiKEY+WXslrs6p/SQP9rmHaISdVfzIAHzLs
         DQjNpz1HyLpBNSMDi/1b2ATsy5jNzcjeTs1NTKJBb0ai6lEzxYOmvnygLvYpx9w31VmI
         oQod3Xwj9OIUoYALQdmTw5CoHsZStde/eNH2mOmjDcTEILUNH5Hm+ACW7LJCu1+BCQm9
         YO5K9Uai0ykrHgThqZ9q7aHqoBC6JpRXI4ajh0eI7eHp9Tl2edQbcAt8G0cOVOj4T3G8
         xRzw==
X-Gm-Message-State: AJcUukdiX3gRdbT1BkLadPjrZAElaPdgAVf4ZFAEa6/UZMy7bjE22IEe
        TBj2dNRGS0Sh21bYyHz8aFbXFyLo
X-Google-Smtp-Source: ALg8bN4E/IrOdBzSYr5zkTOTrZTXFyvmogyU06ajKfzb/tYPZ0AtQZpgLwbJg3Ts307f0em5sCM8IQ==
X-Received: by 2002:a63:4819:: with SMTP id v25mr8481091pga.308.1548389107150;
        Thu, 24 Jan 2019 20:05:07 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id l5sm31633380pgp.82.2019.01.24.20.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 20:05:06 -0800 (PST)
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>,
        linux-block@vger.kernel.org
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <68bc5bc7-6bb6-fce8-f213-cb94c8ff9a40@acm.org>
Date:   Thu, 24 Jan 2019 20:05:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/19 1:01 PM, Florian Stecker wrote:
> on my laptop, I am experiencing occasional hangs of applications during 
> fsync(), which are sometimes up to 30 seconds long. I'm using a BTRFS 
> which spans two partitions on the same SSD (one of them used to contain 
> a Windows, but I removed it and added the partition to the BTRFS volume 
> instead). Also, the problem only occurs when an I/O scheduler 
> (mq-deadline) is in use. I'm running kernel version 4.20.3.
> 
> From what I understand so far, what happens is that a sync request 
> fails in the SCSI/ATA layer, in ata_std_qc_defer(), because it is a 
> "Non-NCQ command" and can not be queued together with other commands. 
> This propagates up into blk_mq_dispatch_rq_list(), where the call

Can you have a look at 
https://bugzilla.kernel.org/show_bug.cgi?id=202353 and see whether that 
issue is related to what you encountered?

Thanks,

Bart.
