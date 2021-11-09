Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B5C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9399610E9
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 15:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbhKIPRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 10:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbhKIPRl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 10:17:41 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DDC061766
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 07:14:55 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id v23so8367018iom.12
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=cuLupL0qeqkrPOQGvhaPBdy4ZNfF/HvnVu1GlBW2I0w=;
        b=kmQIvoYyag+9tIB/F156SVSLwPLJxQOT/kSY2gTku/cXg+WCZGtwJAsIZtOAmQnni1
         9BK5F+HdbpYw9mYqbaJN9qfLdZ+VtRV6IYn4dnxieAj/ftqzLleJJUo/oiLF3BBhE25l
         uATHJ+70MXjnINc6A/RYsiMCTGOnhPgkmf/V8aaea20ODRxMIkOaS81wx/9ayLWNw4sp
         mOkypbzdzvzXn+g1aay7QlfmEb4Zz8g26376gU+58OH9JO1wjOnuyyRtYIcmRYf6T2u2
         LMADY+MGO5bDRb+alUkIS88ocq4SoiPNdw9tdURKdIU7lqXyVZuq5XHb+oImRhS+1KfP
         MMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=cuLupL0qeqkrPOQGvhaPBdy4ZNfF/HvnVu1GlBW2I0w=;
        b=b755Qs95DxmaC1dGmwNek52UwotNs1r+Q3q/aHiv5XIHTM9RDj0rpfEBv1y5/4TAhg
         HXK9GWuV3Vqkz3RkyEDPNid131VbZbAEHf7XtUTdTAQjMBviSSHgEoFPG/w+gA9L9K7R
         rRYMcEhWBBEcwmh19+7zM3G0ih/cfmps/7Xxlv5byFBwnQ1bIVclkrvX2aTtcWvPOm5B
         s2o0goNNsB/iyC1LoaGZ6WE2UfIBJSEhxVSW7mUVYCVbtsjtc94jER8mAFuH/R148d+L
         VBrBfoqvlAPU4lQQzvD/z34rjNs7lUid/tDGFIqxqyDKqgtx0w8MtE0ShAuwXtZlUjQ7
         9sEQ==
X-Gm-Message-State: AOAM533/BIoKPPNOo5lBBXkzvU0ysxrsCAlMqfpxPqQK+m06lmdMhYKn
        aBK/4S068CH2PiZF29EmNuohuA==
X-Google-Smtp-Source: ABdhPJxRmOq51TfrRGB5R/m0NitxjqMuxR9iNz/jrvLmzwxbSv/3ZYKZv782sq9+OjNVuVtQi1GtLQ==
X-Received: by 2002:a02:a11d:: with SMTP id f29mr6313385jag.78.1636470894294;
        Tue, 09 Nov 2021 07:14:54 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k8sm10290379iov.11.2021.11.09.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:14:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-nvme@lists.infradead.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
In-Reply-To: <20211109071144.181581-1-ming.lei@redhat.com>
References: <20211109071144.181581-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/4] block: fix concurrent quiesce
Message-Id: <163647089353.413881.8401016435701752543.b4-ty@kernel.dk>
Date:   Tue, 09 Nov 2021 08:14:53 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 9 Nov 2021 15:11:40 +0800, Ming Lei wrote:
> Convert SCSI into balanced quiesce and unquiesce by using atomic
> variable as suggested by James, meantime fix previous nvme conversion by
> adding one new API because we have to wait until the started quiesce is
> done.
> 
> V2:
> 	- add comment on scsi's change, as suggested by James, 3/4
> 	- add reviewed-by tag, 4/4
> 
> [...]

Applied, thanks!

[1/4] blk-mq: add one API for waiting until quiesce is done
      commit: 9ef4d0209cbadb63656a7aa29fde49c27ab2b9bf
[2/4] scsi: avoid to quiesce sdev->request_queue two times
      commit: d2b9f12b0f7cf95c43f5fd4a18688d958d39e423
[3/4] scsi: make sure that request queue queiesce and unquiesce balanced
      commit: 93542fbfa7b726d053c01a9399577c03968c4f6b
[4/4] nvme: wait until quiesce is done
      commit: 26af1cd00364ce20dbec66b93ef42f9d42dc6953

Best regards,
-- 
Jens Axboe


