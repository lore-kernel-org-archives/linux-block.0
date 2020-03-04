Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53437C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 05:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A48C214D8
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 05:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3vgVSVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgCDFlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:41:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36869 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgCDFlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 00:41:21 -0500
Received: by mail-io1-f67.google.com with SMTP id c17so1060490ioc.4
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2020 21:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oGAsqYc72bEoMm5c+Kg6/9OPUTzZE5w2WwigLaxaXoI=;
        b=V3vgVSVi1PifYH8/BiyQQFw+AKBMrayaornjaWtah8jcSlGaUO2Y/9+PMk2zB8fpT6
         4D89K/f1z8JoD49rhR8BqBQ4q4OnDyDpXFH5BPuQFpG8LWjoO5RJaZ2bcRUEbT2Zgjhg
         eGVo3rN6a6iEEFXCjkoYH+jRoKSFaGyiufKuDJ3WFSPAGAqeBLKST/6BK8IVJ8rWhmI/
         cy7kCFmbzk0fY1ceMvvbyyK2UFMB8fOhzZhYdUryeao+todDatjf5QVx7wVvyBcUUglP
         Dz0UfhyoZgJNrZGNl7srlV+W6+0wqDij1I+QfhQ5uMEz/VKwUo0vFCdhBQ+xvd8kHIlL
         54/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGAsqYc72bEoMm5c+Kg6/9OPUTzZE5w2WwigLaxaXoI=;
        b=I8AWImtVkTTADXlTvUT6u+oaDmwmUyOjImGx1RBRatjz8izYtl2cDvDhy08msHR+CD
         P3ePMq1KpgK9JP7p63xgbp74Fpc4HkbxU2R9iHyDQw+BrQ78j76jSZVmo6cSumZM0tHn
         VJOdefO2mYFhPUj6h9WMuZMwUnSHToCy9kVo9jsOCFpKwalqoZRcAqxsqdfyn9cLd3Vi
         86pkunQFOoLcEysDU6AMqtcX9ZMsxvpteI3Qr2leKgsWEBCPZVP1hceU/VL9r2p/voPh
         q9aDQlfKbfEwLYuyDKEwlBWcd1r3xRqV/Z8Ry7TjWzj8X2W/abjnUBsHFkkMAxlod4dn
         dIhA==
X-Gm-Message-State: ANhLgQ3JR27ExqJ2InZ7OFIw6pwjIG8OlHPuqpYa4c08tBXoSNprIYSF
        uIcN7Zeqs2xaSrDw82X+9W91E0JTixRXU2dn9vY=
X-Google-Smtp-Source: ADFU+vtqFzkx1K1tdQMfqVQtrOXcymEVV8gqsk34YleyT3LfeT8jqC+J2+9c4cJo9fn3+CQFi+5YWWuoz/+OkhrEdUs=
X-Received: by 2002:a02:17c2:: with SMTP id 185mr1256156jah.120.1583300480275;
 Tue, 03 Mar 2020 21:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20200228064030.16780-1-houpu@bytedance.com> <20200228064030.16780-2-houpu@bytedance.com>
 <3b6ae210-f942-b74d-1e53-768c7e8c3675@toxicpanda.com> <5E5ED0BF.7030407@redhat.com>
In-Reply-To: <5E5ED0BF.7030407@redhat.com>
From:   Hou Pu <houpu.main@gmail.com>
Date:   Wed, 4 Mar 2020 13:41:09 +0800
Message-ID: <CAKHcvQg5usROp-53Nm4r06aKcJGACC6R-_o2wktszekmeHWF=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] nbd: enable replace socket if only one connection is configured
To:     Mike Christie <mchristi@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 4, 2020 at 5:48 AM Mike Christie <mchristi@redhat.com> wrote:
>
> On 03/03/2020 03:12 PM, Josef Bacik wrote:
> > On 2/28/20 1:40 AM, Hou Pu wrote:
> >> Nbd server with multiple connections could be upgraded since
> >> 560bc4b (nbd: handle dead connections). But if only one conncection
> >> is configured, after we take down nbd server, all inflight IO
> >> would finally timeout and return error. We could requeue them
> >> like what we do with multiple connections and wait for new socket
> >> in submit path.
> >>
> >> Signed-off-by: Hou Pu <houpu@bytedance.com>
> >> ---
> >>   drivers/block/nbd.c | 17 +++++++++--------
> >>   1 file changed, 9 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> >> index 78181908f0df..83070714888b 100644
> >> --- a/drivers/block/nbd.c
> >> +++ b/drivers/block/nbd.c
> >> @@ -395,16 +395,19 @@ static enum blk_eh_timer_return
> >> nbd_xmit_timeout(struct request *req,
> >>       }
> >>       config = nbd->config;
> >>   -    if (config->num_connections > 1) {
> >> +    if (config->num_connections > 1 ||
> >> +        (config->num_connections == 1 && nbd->tag_set.timeout)) {
> >
> > This is every connection, do you mean to couple this with
> > dead_conn_timeout? Thanks,
> >

Except this case tag_set.timeout==0 and num_connections == 1. As Mike
said below.

Regards.
Hou.

>
> In
>
> commit 2da22da573481cc4837e246d0eee4d518b3f715e
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Tue Aug 13 11:39:52 2019 -0500
>
>     nbd: fix zero cmd timeout handling v2
>
> we can set tag_set.timeout=0 again.
>
> So if timeout != 0 and num_connections = 1, we requeue here and let
> nbd_handle_cmd->wait_for_reconnect decide to wait or fail the command if
> dead_conn_timeout is not set.
>
> If timeout = 0, then we give it more time because it might have just
> been a slow server or connection. I think this behavior is wrong for the
> case Hou is fixing. See comment in the next patch.
>

Yes. While we are waiting for a slow connection, we also take care if the
socket is reconfigured.

Regards.
Hou.
