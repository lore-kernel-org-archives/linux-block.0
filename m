Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCCC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 19:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A0B21019
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 19:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvqJwek0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfAVTOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:14:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45779 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfAVTOA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 14:14:00 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so21612146ljd.12
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 11:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmYlTpQ95R/cSsmQUKU8G4lAg2996kafwYSWFGCYB94=;
        b=DvqJwek0LS6mkFBqisc3vNmCDLvahOIaC5D0V7G1gZuYAquOReP5lTa5XQHZenx8pX
         YletYr17Q+DmxP/j/eJjuovogcI4xqZpmv8oDxFddF5WTHugKUPudlHMr7G87fcKYSO7
         IZNbeskETUxTRHrfI/0cuQj79oelSE1fmrZ2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmYlTpQ95R/cSsmQUKU8G4lAg2996kafwYSWFGCYB94=;
        b=YIavMk/EsDohWjNdIBbJaezy3+xN1U8FJ+9Gw9eTwyxZSK4usTDArOCSQK3GyIF2yC
         u/B0gbGdoFFDcb+XOXLfZSZ74hPN5dETOrUe22AKwPaxX6YR9e9HkwMALiYe/Ytrs9yN
         Lrcz4v9druGOQ9Ycd7PMjeUXA75wDvzagJZzrJ9qQGUjrvldKQOcnFJRvsxrZPfS4zKH
         95t28mcIxoeMZlgAQY7vQWX1lNGP+PCKcV2pa1hf/psgvYlzzU9e2BlvRqtUiUHiDWkd
         XNc7T0cnjUV6ZaqIcydg2s9Stu/JwySNxZ5Ky2U+cmJQXOjsMlHdnr1FzsSqSHPSJ6uW
         CxlA==
X-Gm-Message-State: AJcUuked1xImvrexiPbCypupych8e9zk7dfj9+17VOEw2kQI1yWGlx+3
        IF3ULJMjL7Yg8Je8Eyjkpot4+CtjESA=
X-Google-Smtp-Source: ALg8bN4j7rwWyS4jBLd5P3+j5mfjfyg8roKiK2B0UCqLkd4jhZ2YjuP+U9kLEoneH2sdiqWQd2De4Q==
X-Received: by 2002:a2e:5854:: with SMTP id x20-v6mr21042924ljd.31.1548184438416;
        Tue, 22 Jan 2019 11:13:58 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v9sm134616lfg.15.2019.01.22.11.13.58
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 11:13:58 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id c16so18916150lfj.8
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 11:13:58 -0800 (PST)
X-Received: by 2002:a19:7352:: with SMTP id o79mr22814922lfc.104.1548184097075;
 Tue, 22 Jan 2019 11:08:17 -0800 (PST)
MIME-Version: 1.0
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr> <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk> <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr> <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com> <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <fdfe4600-9bf5-0b6e-cd45-4ca836a477fe@free.fr> <20190122162246.GA22548@kroah.com>
In-Reply-To: <20190122162246.GA22548@kroah.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 22 Jan 2019 11:07:40 -0800
X-Gmail-Original-Message-ID: <CAE=gft7PorTqWqZ_21999jU1YwAz3T+HSj8K5BML3hTjM9+8+A@mail.gmail.com>
Message-ID: <CAE=gft7PorTqWqZ_21999jU1YwAz3T+HSj8K5BML3hTjM9+8+A@mail.gmail.com>
Subject: Re: dd hangs when reading large partitions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FWIW, I am unable to repro this in our 4.19 kernel [1]. I put mem=4G
on the command line, and can dd till the cows come home. Seems like
you're leaking buffers somewhere?

localhost ~ # dd if=/dev/sda of=/dev/null bs=4M status=progress
12683575296 bytes (13 GB, 12 GiB) copied, 125.004 s, 101 MB/s^C
3048+0 records in
3047+0 records out
12780044288 bytes (13 GB, 12 GiB) copied, 126.015 s, 101 MB/s

-Evan
[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.19
