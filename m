Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E45C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52610208E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Jccb9ZUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52610208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeKPF32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:29:28 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:38366 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeKPF32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 00:29:28 -0500
Received: by mail-io1-f45.google.com with SMTP id h4so11168742iom.5
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8FifLWWLapcA6y5G+CqDOomtLExpHr2Jp4q+ePy40A=;
        b=Jccb9ZUNHEucM78BPlBvaErAKYBv3iC2LYSzNJYmFKhjmAFlmTZpVX5kG/AW9q6al9
         TrdYB8yNS0KHo4d/fbc+FMDzM96xiyya+YYOpqm1qKxLikATDizc657PKfrCG/FVrUHd
         JylbGk4MaVRTOxphwidQICcoz5NkVI1gbNUNHe+CJcW4Q8QJAEQd+1maJFmzBoRvtDZR
         3qR5E6QY7j5/CuvZ8lPsn/F9iz6Sl09zCR0ngbmahfbN4ev6Rn73pmvm76lDhmOinruw
         kyjXNryDlvZ3Y1YvnGPaxty/F3GavuPvwddFDPCzlHsxmlClvQMBoyS2Vx8V/+sNeljL
         PBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8FifLWWLapcA6y5G+CqDOomtLExpHr2Jp4q+ePy40A=;
        b=pvlB+Nw1xXlgEThOUPa7tbi8lPODcW2dBHYxiFsA/Fl81RhvDx9vfTLOTz+esf5Tf7
         NZT+6sLX+qu49ovP00hGPxrr6bAKSwgYCjuahMhCuLHMzEfDPGX6K/zvAC+BdcOsjgf2
         jTrxm2mHfI4HrVNIxw4vE/4Naev2ceNqIQS4fZu7QSNQlfNvY/Bd0aU9lbhQ2zHxH3SQ
         95GuQho+xmoXasJ1yJe2Nws4aPL6l3aW4QzHytW8pajyaz0o1PLuFQCaiV1ZsJk+J4nD
         DV5i0hpT5RVtsJf/ogX81QfqWkenlXnvrMujgW9yW6i2+q2eXYlppD6M7No09GfolmaS
         qRsw==
X-Gm-Message-State: AA+aEWblbU56in8/fPJKu7W1drnszR5Meg3wzMW02cSDYakHDAQ1hH29
        X/5mWRr+vFzSXMHVYgs+rj1JPg==
X-Google-Smtp-Source: AJdET5fToqO2t6PcXI+EhI8a7fbvS1897/H9cD8OA58dlHMohxS4xmNPDHTFFK9+BQDdPMSMLGHRAA==
X-Received: by 2002:a5e:9306:: with SMTP id k6-v6mr5919921iom.53.1542309623565;
        Thu, 15 Nov 2018 11:20:23 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id k17-v6sm10847639itk.9.2018.11.15.11.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:20:22 -0800 (PST)
Subject: Re: remove more legacy request leftover
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        drbd-dev@lists.linbit.com
References: <20181114160219.28328-1-hch@lst.de>
 <6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
Message-ID: <3999c98e-e477-c7d0-0a7f-a65d69f3e4e1@kernel.dk>
Date:   Thu, 15 Nov 2018 12:20:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6927069f-46d4-2d37-058a-c9c9b9d5360d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/18 12:14 PM, Jens Axboe wrote:
> On 11/14/18 9:02 AM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> this series removes another bunch of legacy request leftovers,
>> including the pointer indirection for the queue_lock.
> 
> Applied, with the subname part removed as mentioned in #13.

Your patch #16 missed a few spots, I fixed it up. JFYI.

-- 
Jens Axboe

