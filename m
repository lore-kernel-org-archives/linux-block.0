Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0215AC433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C876020679
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe5iapZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfHMGKh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:10:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36115 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMGKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 02:10:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id p28so356116edi.3;
        Mon, 12 Aug 2019 23:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nDqwpC1PppEk839MgFZPsscd9ykxNNHqiMTtehSc/zo=;
        b=Fe5iapZq7OOYHH5az8a2OmwaeUZo7LYmEH/pXBcrEYRZLstiljVxGNHow5U4z5RIh8
         RJDBweOkt4NWgKKYdysVug58aW7GzWS4TJHTsr/o8F5Wnz4EEtHs9wv5MphGnEHY7mMR
         vKeD0pwuU6ri0O2sMuZDAtkLLv+KV0VeKRReP65rVMvLxtzrKS3TajypcHyVRsE0ysXT
         EXJ1QHOMF+XF17gAHIyHOK4Z/T4jVHQM/mWjB8BdEHca0uCS6mrYJr7CdK5rn9JAluyX
         lefiA/s1W1YxedERV4XyQv5wmtwOtKYn//hlCE6T6kd0H25v+BNJ+EOE8a5FLVP02kPx
         8VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nDqwpC1PppEk839MgFZPsscd9ykxNNHqiMTtehSc/zo=;
        b=RZYD0AfJFDWeH5ZpNPW8l7iaQXRPWyM7YZ1CAVz8m2NuQeM4eXlmv1dPr6bY6vNsL6
         4S4CRmgG0hPfpR61BEcvMnQ4l8hIEFawAzdWOltLVGAnK8uIcvHSJdCwLpxHb4EAnd6q
         fEhW8LhqmQn8cP7VuVE4yfnIxUYkn8SytuiQa4p5VvMQC9r7mukwYmaXMQ0qnwkPoKA1
         gVE5HJA1C8jELnMk3HreY2DhzGdmwWN9Qj1P+4crH+vBJRNLdiLeu8SMV3/Xiw7Sg4JN
         5ii+qOkVFb4imkErjX7AhUz0W0TPIXdceZl0Ri+RAM9+uOSxX/EjwPEZSpRZURZWJJCd
         StGw==
X-Gm-Message-State: APjAAAUiwp5VGqy6U10nV977zGoBOHF5YRwEYV6vDx1E8Vm8nD9EKv5P
        b9jwwefjskhJbY2iG8kxVF9AFMyLmoI1aS/luyA=
X-Google-Smtp-Source: APXvYqyHX5dcmE4UHIKGY5NpLFRCXSJoPQaFcBUcTG6uiWonwqF2tldHAIbIEtrKDwn1CYazb48p3zjt9Wk/kLjTztA=
X-Received: by 2002:aa7:d781:: with SMTP id s1mr40421978edq.20.1565676635498;
 Mon, 12 Aug 2019 23:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190808131100.24751-1-hslester96@gmail.com> <20190808133510.tre6twn764pv3e7m@Air-de-Roger>
In-Reply-To: <20190808133510.tre6twn764pv3e7m@Air-de-Roger>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Tue, 13 Aug 2019 14:10:24 +0800
Message-ID: <CANhBUQ3rN+nLOHFGEAaQV6rB7Ob2wf9iLUiP8pjWM0NDMC4Qxg@mail.gmail.com>
Subject: Re: [PATCH 3/3] xen/blkback: Use refcount_t for refcount
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 8, 2019 at 9:35 PM Roger Pau Monn=C3=A9 <roger.pau@citrix.com> =
wrote:
>
> On Thu, Aug 08, 2019 at 09:11:00PM +0800, Chuhong Yuan wrote:
> > Reference counters are preferred to use refcount_t instead of
> > atomic_t.
> > This is because the implementation of refcount_t can prevent
> > overflows and detect possible use-after-free.
> > So convert atomic_t ref counters to refcount_t.
>
> Thanks!
>
> I think there are more reference counters in blkback than
> the one you fixed. There's also an inflight field in xen_blkif_ring,
> and a pendcnt in pending_req which look like possible candidates to
> switch to use refcount_t, have you looked into switching those two
> also?
>

It seems that xen_blkif_ring::inflight is 0-based and cannot be directly
converted to refcount_t.
This is because the implementation of refcount_t will warn on increasing
a 0 ref count.
Therefore I only convert pending_req::pendcnt in v2.

> Roger.
