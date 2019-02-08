Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B917C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10DE2086C
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfBHPtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:49:50 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39528 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHPtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 10:49:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so1739892pgp.6;
        Fri, 08 Feb 2019 07:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMzGy6XshdWiGg39MNWPhorgETSh6qReqAZKsddUeJY=;
        b=Zva96VqvT8ML95s2FP071nX2fdVCq+62pO5APPUcNgbpLb0COQUMJ+IlR/JJAWrwyw
         UEBEBR4B5S+odMFzHwtNPgnlfFCqunN1GhUIS9WJBblRJtDhExJudwepp6jtqZRQUVaA
         1Z2zP6S4yW8ZfCd2pyJskcq7yock7qIU8nq3oPQ9+0SlGwZbGMZfkP8MKFvlD8uJH2xz
         waXS8UcmWez17cJNK5Daq9tcXTtW1se5RqkNIxpgNBVsvlgRH23BCWeLPyaaG+h4uPEZ
         kV+rajWDCRFqRxjOptE3bdzXhuFM3w40HO1aX4GgMsa4Ty8Dp3WzmsD8DrM8mJj9fFbn
         9Ocg==
X-Gm-Message-State: AHQUAuYAlJnZHHyzZRTnpYvt/z0/ivEkFPlxS6G/ZggjHodJBrr5cllM
        7uXm2fm8GHKwUSbvgoyZx34=
X-Google-Smtp-Source: AHgI3IaWMZTNClRldfOGnzX91Uc+YoZ9yGwucpm3tZr9RDtWfe8ij2+LBk77LmkHwi4jwbfT1rFe8A==
X-Received: by 2002:a63:f844:: with SMTP id v4mr16078996pgj.82.1549640989265;
        Fri, 08 Feb 2019 07:49:49 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x2sm5458013pfx.78.2019.02.08.07.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 07:49:48 -0800 (PST)
Message-ID: <1549640986.34241.78.camel@acm.org>
Subject: Re: dd hangs when reading large partitions
From:   Bart Van Assche <bvanassche@acm.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Date:   Fri, 08 Feb 2019 07:49:46 -0800
In-Reply-To: <66419195-594c-aa83-c19d-f091ad3b296d@free.fr>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
         <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
         <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
         <20190119095601.GA7440@infradead.org>
         <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
         <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
         <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
         <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
         <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
         <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
         <0cfe1ed2-41e1-66a4-8d98-ebc0d9645d21@free.fr>
         <d91e8342-4672-d51d-1bde-74e910e5a959@free.fr>
         <27165898-88c3-ab42-c6c9-dd52bf0a41c8@free.fr>
         <66419195-594c-aa83-c19d-f091ad3b296d@free.fr>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-02-08 at 16:33 +-0100, Marc Gonzalez wrote:
+AD4 Does anyone see what's going sideways in the no-flag case?

Hi Marc,

Does this problem only occur with block devices backed by the UFS driver
or does this problem also occur with other block drivers?

Thanks,

Bart.
