Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8700DC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4AD206B6
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 15:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbfAIPRJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:17:09 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42800 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfAIPRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 10:17:09 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so6948232otk.9
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 07:17:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwSV1PGyH8nJvFuGKp+271hYial/3Zh8eRYcPz53b1Q=;
        b=tTcwSRYlHtrKrcVIn251/3AI9w0Eo3Tr6EtHepGpbBQkKTuuy0JG44Rfh/ZZVvYiSd
         vdYj/WAeapZj7CHznWHf/XEYa3t42+tLmXgT97caNCV+DoRysqPhDTToz+ti/SMHrRNN
         qHgq5gpGcWSX4hl4+SS+w5wIvqyaROA+eUAV5kPLJGKPterHutmPpulE2lUg+HKe3/Dv
         dM/oTRklouArp0GtusX0p+C2Osy48ZuFPzsL1E+BNSMB4Kf8jm6AEOplbtgYt4UxTRLD
         iUVspmK12OQfbo60mDtDPVnhBryXTg27qvhScbtMpUVzat/z1oBd9+JC+FeVkNiUOa6B
         mpVA==
X-Gm-Message-State: AJcUukfi0kzI38adRZA5S9PKRCseNMQNRBOFifwqsJLmMe984nJ2B17i
        Wwa4yF1uvoRR0fAiexEFPEf33k/Bewf1JlhAWqek+3Xs
X-Google-Smtp-Source: ALg8bN4TzDbQsVYl2wfHPQrbEuDYLcv6eQzwDOqKLBQwUNyMrz3j29wehI5ikno+twZTNbtNomkUIfSSA0SmdEy7TUg=
X-Received: by 2002:a05:6830:1414:: with SMTP id v20mr4419693otp.125.1547047028980;
 Wed, 09 Jan 2019 07:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20190108215613.15277-1-jpittman@redhat.com> <64f1bba8-1a6e-5aa0-3357-edfdcd7de574@kernel.dk>
In-Reply-To: <64f1bba8-1a6e-5aa0-3357-edfdcd7de574@kernel.dk>
From:   John Pittman <jpittman@redhat.com>
Date:   Wed, 9 Jan 2019 10:16:58 -0500
Message-ID: <CA+RJvhyTDEhpBnVa+POLxtH5g+tW0tTsPEbSbYPc9BN8rUAw0w@mail.gmail.com>
Subject: Re: [PATCH] block: doc: add slice_idle_us to bfq documentation
To:     Jens Axboe <axboe@kernel.dk>
Cc:     paolo.valente@linaro.org, Jonathan Corbet <corbet@lwn.net>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks; noted.


On Wed, Jan 9, 2019 at 9:39 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/8/19 2:56 PM, John Pittman wrote:
> > Of the tunables available for the bfq I/O scheduler,
> > the only one missing from the documentation in
> > 'Documentation/block/bfq-iosched.txt' is slice_idle_us.
> > Add this tunable to the documentation and a short
> > explanation of its purpose.
>
> Applied, but I fixed up your commit message. You should use 72
> chars lengths.
>
> --
> Jens Axboe
>
