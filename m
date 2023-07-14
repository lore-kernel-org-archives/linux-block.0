Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997BEB64DC
	for <linux-block@archiver.kernel.org>; Fri, 14 Jul 2023 17:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbjGNRQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjGNRQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 13:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F691BC9
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 10:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689354958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+Go+FABT/1LBKriDt9DKdVG70Q2eMxg/FwWUtltL5c=;
        b=OoZ32kV+EzgMU/OAlN1MPpbfi3Cut5ouQlVFqOoVOGwsYXg4VNrpwlc9eKTrfwExXPsM0a
        s79kT1VMY7R/16BNqsAm+BunTni1FuCG3cQjIZWFSAFxiaCTBDI+N9QnAaTdc1nSnLI61m
        H3iUtnrM1bjqV6mUI7WwD38gEu4w6UE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-SDbRm4MCNLi9ih4hpaA2lw-1; Fri, 14 Jul 2023 13:15:57 -0400
X-MC-Unique: SDbRm4MCNLi9ih4hpaA2lw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fb9c4b7020so1944019e87.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 10:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354956; x=1691946956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Go+FABT/1LBKriDt9DKdVG70Q2eMxg/FwWUtltL5c=;
        b=XwBh/Ven5B9z2AzratAUQ5UwcJWeTrOrkcJN0NQYVflkvEF07DEO/hyrnkJVSEFKUw
         /BXAQ5EnqEN1pcprOM2AIak0tK0udGP+T9RrxlsY4WnbJKOYrjEUWuTnMNLx7hsUIchB
         ivJ8Lo83pHjp3NupPmH13sR/SEK2VCw/LTYbx3VV06t537aAGjsqwAzsMwqlBGJLV0iu
         amXYLrzaI3zUOYs1uqniH+/KOlhYCpXX4QfwhkGuTQjyTHIUew3TYu9rrypzPngdfoX6
         gg3UlpMcPfMA7pbPFBYPJX9mdGyKeQiKxtpu/m53kYAw9/qItQd+gBrRW4Z/9CAzxW2B
         r/FA==
X-Gm-Message-State: ABy/qLa0ITtkAKxqfJSwrPuFA6qqy2P8E36VxZB6Q/trKvjztCNyrXu3
        1FGm2GYgrqcpYOB34XYhu33N8zIgjE3vsPjobupMD7T7LJFl1XBtNJ2EnIT414Su2z+OHpaJTEW
        plvjnI5QdMm/TRfDvGeE6hU4Lo8OsUhW2L54Snng=
X-Received: by 2002:ac2:4114:0:b0:4fb:7da3:de4 with SMTP id b20-20020ac24114000000b004fb7da30de4mr3870848lfi.13.1689354956227;
        Fri, 14 Jul 2023 10:15:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIMGc5IdkqFd3glR4wUdXvSkfPZda8hXBuzfyVsLh9uDQXT5V2ZfmVVHM4X6tdhCau9+1VW4v/lUXjjj1bov0=
X-Received: by 2002:ac2:4114:0:b0:4fb:7da3:de4 with SMTP id
 b20-20020ac24114000000b004fb7da30de4mr3870835lfi.13.1689354955949; Fri, 14
 Jul 2023 10:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230609180805.736872-1-jpittman@redhat.com> <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
 <CA+RJvhx0G7cLeQ1krpD8Noc7iZYcC4bMaVNzVsrcOrXE=yCdNQ@mail.gmail.com> <yq1edm6rxgy.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1edm6rxgy.fsf@ca-mkp.ca.oracle.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 14 Jul 2023 13:15:19 -0400
Message-ID: <CA+RJvhwaEnj0Yk3MW75+nQsOjVFEQQxCj2DcO2EQ-jpCL_ec-g@mail.gmail.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, djeffery@redhat.com, loberman@redhat.com,
        emilne@redhat.com, minlei@redhat.com, linux-block@vger.kernel.org,
        ming.lei@redhat.com, Mike Snitzer <msnitzer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Martin.  Sorry for the wait; it took a while for the user to
respond.  They don't have scsi devs but rather nvme devs.  The sg_vpd
command failed b/c there was no bl page available.  I asked them to
provide the supported vpd pages that are there.  I do have some nvme
data though from a sosreport.  I'll send you that in a separate email.
Thanks again.

On Tue, Jun 20, 2023 at 11:20=E2=80=AFAM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> John,
>
> > 1) Set a 64M limit as you've suggested in the past.  It seems more
> > prudent to tune the value upward for the few devices that can actually
> > handle a 2TiB discard rather than tune downward for the large
> > majority.
>
> This makes the assumption that smaller always equals faster. However,
> some devices track allocations in very large units. And as a result,
> sending smaller discards will result in *slower* performance for those
> devices. In addition, for doings things like the full block device sweep
> we do during mkfs, it is often imperative that we issue large sequential
> ranges.
>
> Please provide the VPD pages from the device in question.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
>

