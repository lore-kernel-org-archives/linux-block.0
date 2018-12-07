Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4270BC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EF820659
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 02:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sjz8RwiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EF820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLGCQK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 21:16:10 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:41753 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGCQK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 21:16:10 -0500
Received: by mail-pl1-f175.google.com with SMTP id u6so1066968plm.8
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 18:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XGMb5TwzKuS0+DvsIMBSLNeT4mgkUjy8iqbDd4p6Wds=;
        b=Sjz8RwiLbY51rrx7T1DvWiZvovz9Y+6g6pm6Wov4PHXSAgkLS72JmH3O2RJwjTT8aK
         iSOXsMqGJSyfurI+L8C53lPgzsGoyVVsnbYF3lOThlvmTZQ4grulHOz8kG1scywDsbS3
         JnxHy1DMXjtLHYZiKmRCmO5DXnDzNExazO4XcdDBLSRqrk/s6GxaxslJrgx5AyTHvZyJ
         M0zTDbM2fKvib3SI9Ejw87hM8sUQ6QSdDhuKUSDH27dALjstQnZLhJdRVAtbG34JS0DW
         FXz3IIuBYoxKVBRxwKlURChBbPA+UEUC8QhJOXEspbN9KmoqVJRw0vSwO9lSm604a+c/
         1XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XGMb5TwzKuS0+DvsIMBSLNeT4mgkUjy8iqbDd4p6Wds=;
        b=uTVVp4qBgs1FMAFJDi7CXl36/AcQEPVKY+xLFYV9c3U7+jvDTLohZLwVYa1zheSsm4
         Omb5QftaHsU9Ivr2EOz+2sCq2vzcDwx8xnWu3Flc89tbQ9pIv4UsaG/xrBtSheWfon1K
         AWPEsNsQriKJnbeSvKg8JB5Hq50WTWe+6jIBRInj1etSLQWfalrnXpRfaYcOjVP1EvQ6
         gxp1ViX1R36ghDbZ0Mm0qdL4SrAHNuyYd2bURbUej7rKwi2DG1nIRKtNpIm/tYE5OPf9
         e748l7pV4NhqZb0Zb5Fvhl8w8SrgyAiYRcR/yb4I8CpVEjezFKglaTy9RAk9i11fs2n1
         Pvlg==
X-Gm-Message-State: AA+aEWY9Pzp7TrL3QyFNXaUYC/xFWYjgA0uOi2/G0teNbBsvIoH9lFk4
        idCpsk+z4TMPDn1sKzA51rtiCg==
X-Google-Smtp-Source: AFSGD/XDuSwJrYxN2escEC+AdDvgwfrfh5OGqEsw64esYbLJFXBRazpYTXUHeV7DHwd5RRnQYXaSrw==
X-Received: by 2002:a17:902:380c:: with SMTP id l12mr401618plc.326.1544148969558;
        Thu, 06 Dec 2018 18:16:09 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v5sm3047017pgn.5.2018.12.06.18.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 18:16:08 -0800 (PST)
Subject: Re: block: fix direct dispatch issue failure for clones
From:   Jens Axboe <axboe@kernel.dk>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <adab29e7-6f9e-0804-5630-73e92be6a990@kernel.dk>
 <0d754fbb-9034-e375-a71d-9262ce8300ea@oracle.com>
 <e2c1c79e-89e5-4a09-d276-b1af5230f625@kernel.dk>
 <671bf8cd-672d-55ed-ad1e-1deb0b17f701@oracle.com>
 <36822da2-ecde-ad71-7b49-f98e845b4fc2@kernel.dk>
 <20181207015830.GC17427@redhat.com>
 <782a0a84-ac8e-31fc-255c-1f967a4740dd@kernel.dk>
Message-ID: <e82ead29-6e44-fcaf-a817-6284d20312af@kernel.dk>
Date:   Thu, 6 Dec 2018 19:16:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <782a0a84-ac8e-31fc-255c-1f967a4740dd@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 7:06 PM, Jens Axboe wrote:
> On 12/6/18 6:58 PM, Mike Snitzer wrote:
>>> There is another way to fix this - still do the direct dispatch, but have
>>> dm track if it failed and do bypass insert in that case. I didn't want do
>>> to that since it's more involved, but it's doable.
>>>
>>> Let me cook that up and test it... Don't like it, though.
>>
>> Not following how DM can track if issuing the request worked if it is
>> always told it worked with BLK_STS_OK.  We care about feedback when the
>> request is actually issued because of the elaborate way blk-mq elevators
>> work.  DM is forced to worry about all these details, as covered some in
>> the header for commit 396eaf21ee17c476e8f66249fb1f4a39003d0ab4, it is
>> trying to have its cake and eat it too.  It just wants IO scheduling to
>> work for request-based DM devices.  That's it.
> 
> It needs the feedback, I don't disagree on that part at all. If we
> always return OK, then that loop is broken. How about something like the
> below? Totally untested right now...
> 
> We track if a request ever saw BLK_STS_RESOURCE from direct dispatch,
> and if it did, we store that information with RQF_DONTPREP. When we then
> next time go an insert a request, if it has RQF_DONTPREP set, then we
> ask blk_insert_cloned_request() to bypass insert.
> 
> I'll go test this now.

Passes the test case for me.

-- 
Jens Axboe

