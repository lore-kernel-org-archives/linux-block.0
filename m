Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F72C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC120835
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f2pxPaEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3WMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:12:17 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:36906 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 18:12:17 -0400
Received: by mail-pf1-f175.google.com with SMTP id g3so7752695pfi.4
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 15:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t1A91VbqK3c3rmC3Vayr6AqXf4GJM9U1CcOpZO0SdRU=;
        b=f2pxPaEwo1XMipVGAf0ROHaKcROWSBZu1hdWrOpwWIE/5PDwTGLFSvUWyEfZehzCoX
         GnA8Ch5BM5Bst+5dc3QfzvFyNlnwVrc4ulkeQ959BtW7PXDDmWlIpOoPCC8weoUGDRYX
         zYInoX9+2APh8P+1rzWbU9YRk6WQ2Io+8iTJe6KlKrYFry5og1VkYN7U303nsFx5xXyc
         5rAZ+484o+BxJqjyPOM5Hj86JDh5JeBm6WXkWy7vrM44Et71o2uh6NaSlB+dMukh378l
         578XRYyPRcxPd3ZcGn4dC+dKrOO10063m2D+k9BBpvG4rkXMWmjOqoELT2UwkEsiOFKF
         Js0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1A91VbqK3c3rmC3Vayr6AqXf4GJM9U1CcOpZO0SdRU=;
        b=DDxxgIYeQaLOxfRX3kUrxDWefVQmqGfQtGXtHHOD9mY44d+LSN/lbUkNt8CPuv3bdj
         SlY2oavuEY5VD/y7xcNsvH8GVlGwT6YYKPbSBV8Owd50a2grn0UWg3H/+byXccSVxmRR
         iow7SBVB7P+0OBF7LHh4uqEt9fVzfEhehCs5XSIxOoPLsqaz7jqqVwURhDopcd78Un8x
         PrDuNMBICvacAM+wI5rcYd0haBrODdOYRKDpHoehpRnMH17EAhz1Ur2LM5mNcoynSxwI
         9mkNt9/qwKnNgqXJjDQPmXsePczy8P7OhE2qmvQIwAMfhPcmzaq8xzjS9aQ7qjmehVlX
         tnyQ==
X-Gm-Message-State: APjAAAUXZNxFK1M1PhgyXIQvCqVSp12CjpglgTIr4iogYx02H0Btld2u
        YOTRjDXF9FNNaBKxOqHYuH80RQ==
X-Google-Smtp-Source: APXvYqxAfmnvJ+NJgPRvSHpMMaJ1teBBvFl4KXdpLFc6lO5j7TDU7GYYOdkMrjYJZRQFX9cjNlADww==
X-Received: by 2002:a62:1c13:: with SMTP id c19mr72524742pfc.11.1556662336230;
        Tue, 30 Apr 2019 15:12:16 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id h65sm126756079pfd.108.2019.04.30.15.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:12:14 -0700 (PDT)
Subject: Re: add SPDX tags to all block layer files
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190430184243.23436-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <251a6255-bed2-056d-86c8-918de8d6ca24@kernel.dk>
Date:   Tue, 30 Apr 2019 16:12:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/19 12:42 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series adds SPDX tags to all block layer files that are still
> missing them.  The last patch adds them to files that didn't have
> any licensing, and I've cced everyone who is mentioned in the
> Copyright notices for these files to make sure no one has any
> disagreement with the fact that that they are per default under
> the kernels GPLv2 license.

Applied, thanks.

-- 
Jens Axboe

