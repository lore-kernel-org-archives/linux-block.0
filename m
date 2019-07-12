Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63016C742C7
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3270B206B8
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 15:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CGNvk4/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGLPM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:12:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43266 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGLPM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 11:12:58 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so21008245ios.10
        for <linux-block@vger.kernel.org>; Fri, 12 Jul 2019 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TgV+P5xUNL5epV/ZpLeslnEZ8CdbgVF9nNrx/k03o8g=;
        b=CGNvk4/dqGZ6+i1O+wfwJKZoo7ZYVaVuFsXwbqWoKa2XITkHd3rk7eN+9PMEwi0ihT
         l0BWkPExicPNlcfnNhprd86+MADEO/JMKNcrEfFYDcy4UtSlyJGgqGti1tMF6ZQp1Pw7
         PgB5kmZlAOgYnnICnXaE4Ce6bjaK0DqQ1LgWCGLeCGYaGSWtlukgKp30GZNQ0H4JqKou
         Bhzr1mlWRh38YS94B8YBVD967PLS6In5oR2rO4WHBu5RroQ4ZqfcdoRTxKZGAbtzyhwH
         JSlZc1isR6qSYuSho0mHJeLajd0JRjwkmewOWFe26AkCy+6Kjq6/vqcAg+wTP3Y8clDE
         OwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TgV+P5xUNL5epV/ZpLeslnEZ8CdbgVF9nNrx/k03o8g=;
        b=IThewx33jjbY654Ur4XoQCfjPDF249BihO/IUy+H5NGRbVEAALYnvdRf3lI/Nz3e9K
         nX37cLjd+DcCeyefy1/fLaBBNNFPtQy0iAWTCu4RoaSy7fmYhek4J8Sn+viU224O66QN
         GaBPCN8Ip27hfo7wPDj887xoBRxmymUayTR0k3c7YizXcfmH9q1gAeJFFaT/gTA/cmJ4
         yFsMYRwTjux763YxRRRAysLzv4RpOTAXdvuhZ+GKoNlvJJUBO9iW+/FrPwmaO2+/SAj+
         48HEtygA9w5bHaZQj8GUQAjCqMjAKwoZSZQzQX7d/7RaybXrsmaRBD6kxZNPA6r8MOsR
         xAyw==
X-Gm-Message-State: APjAAAUpjPH0gxXy7/4y4ynciZvztCZsMzloPOOl65NezvkXdg2IC3cq
        45yxb0DpWwdbZ56YE71i3mE=
X-Google-Smtp-Source: APXvYqzNOs4ktys5P/q5Zi/E8ueb3gbQD/m0JLYFVa+rUUweNFsMDDkgPqUBftGoeg2lyKpUDsUArg==
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr11632533ion.239.1562944377622;
        Fri, 12 Jul 2019 08:12:57 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l5sm15960501ioq.83.2019.07.12.08.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:12:56 -0700 (PDT)
Subject: Re: [PATCH V6 0/4] Fix zone revalidation memory allocation failures
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816BC7EC358F5785AEE1EA9E7F60@BYAPR04MB5816.namprd04.prod.outlook.com>
 <cb26f686-ce7e-9d1a-4735-2375d65c0ea5@kernel.dk>
Message-ID: <27386e10-7494-7fcf-f203-484db5c3c69c@kernel.dk>
Date:   Fri, 12 Jul 2019 09:12:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cb26f686-ce7e-9d1a-4735-2375d65c0ea5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/11/19 8:05 PM, Jens Axboe wrote:
> On 7/7/19 8:02 PM, Damien Le Moal wrote:
>> On 2019/07/01 14:09, Damien Le Moal wrote:
>>> This series addresses a recuring problem with zone revalidation
>>> failures observed during extensive testing with memory constrained
>>> system and device hot-plugging.
>>
>> Jens, Martin,
>>
>> Any comment regarding this series ?
> 
> LGTM, I'll queue it up for this release.

This broke !CONFIG_BLK_DEV_ZONED builds for null_blk, btw. Please be
sure to test with zoned enabled and disabled in your builds when
changing things that affect both.

I fixed it up:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=e347946439ed70e3af0d0c330b36d5648e71727b

-- 
Jens Axboe

