Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD22EB64DA
	for <linux-block@archiver.kernel.org>; Thu, 20 Jul 2023 14:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGTOpO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jul 2023 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjGTOpO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 10:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594F2C6
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689864265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kKh3ryYLjboicz3qdOo//FhVYG5xef6YwWGQv6sHMs=;
        b=h8CRMd+E2jhNXE7pj36dYVE9bisx3HPT9UkPxDxBZN85988vMByqWol7XFqjSMyrAdAZ8Y
        Z7+jQkHWMqL+LgmsfAq8D1phE1P8t425Dh1up5qjGkcd6uvu2MK0jdpqkuFajZXqNp2s3V
        GlOoDYycZY+iznBhcVEQmSFgr6xRG+I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-xMMdLPyHPdqiGoOo8c4sTw-1; Thu, 20 Jul 2023 10:44:21 -0400
X-MC-Unique: xMMdLPyHPdqiGoOo8c4sTw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4fdbd94e735so883605e87.1
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 07:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864259; x=1690469059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kKh3ryYLjboicz3qdOo//FhVYG5xef6YwWGQv6sHMs=;
        b=DiP/StHO3+Nxe2K8t30N2VDj0EDozPnCQP1sbvQA+HadJzHiD2117xfR/M+CfdXA0m
         J3gw4OAQgQqsZ84Iqk+t2cmLGRYX3MudPDggaBjXTsS3Ge1xDv3mc57DK/Sr2RS3WUaM
         NJa9GkewFztj10U0lMAP83YtsWdRLvSzgKr+692Wc5FmSH6Xs+mj35jTvFwKN4aDHSx4
         /V4NW+93tTGyc5j7m7IXb+VW6oXxUH28S8vlM1wHdU4z0U6MM2Y+p7R/3k5GYU1hgDHP
         JYfQCZJH8jZgZC7pYDZ+y2nOA+IVCEhOlyf9F3HZT0E3jkT++7OPTnJl6oCK2wVD4oEc
         jYGQ==
X-Gm-Message-State: ABy/qLamjWkLsmIECbNDlcYuAw3jlG5BcNcjthRZAcvrC3d/2flrjNO3
        1pKouEG86B5lAUe43TXtVWbY2vD48+W2Lke2QbpeO7aTEI+NP6F4cZZwPRkqIJAMwXR9jGHEl03
        bfJ2iZgtfpOfsIy1AQZV+sYwgbIxM5Pmk4+EK91Q=
X-Received: by 2002:a19:381d:0:b0:4fb:774f:9a84 with SMTP id f29-20020a19381d000000b004fb774f9a84mr1426872lfa.13.1689864259475;
        Thu, 20 Jul 2023 07:44:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGqvlF3Q31UhqKnGyjEkAoD/0l/LO23yIEAtVwebEaJHCvn+qXZRHZYHSxLw/ZVMK1EPHAFbFyNn1LErGl7vCY=
X-Received: by 2002:a19:381d:0:b0:4fb:774f:9a84 with SMTP id
 f29-20020a19381d000000b004fb774f9a84mr1426855lfa.13.1689864259104; Thu, 20
 Jul 2023 07:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230609180805.736872-1-jpittman@redhat.com> <ZIfIZWthJptVsQ6q@ovpn-8-16.pek2.redhat.com>
 <CA+RJvhx0G7cLeQ1krpD8Noc7iZYcC4bMaVNzVsrcOrXE=yCdNQ@mail.gmail.com>
 <yq1edm6rxgy.fsf@ca-mkp.ca.oracle.com> <CA+RJvhwaEnj0Yk3MW75+nQsOjVFEQQxCj2DcO2EQ-jpCL_ec-g@mail.gmail.com>
 <yq1lefb8iev.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1lefb8iev.fsf@ca-mkp.ca.oracle.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Thu, 20 Jul 2023 10:43:42 -0400
Message-ID: <CA+RJvhz+i59+fMZPjuD2XZNS9rW=Un7RN_qB6n2diwvKHH3pXQ@mail.gmail.com>
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

Thanks again Martin.  We're going to try to engage the hardware folks now.

On Wed, Jul 19, 2023 at 9:58=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> John,
>
> > Sorry for the wait; it took a while for the user to respond. They
> > don't have scsi devs but rather nvme devs. The sg_vpd command failed
> > b/c there was no bl page available. I asked them to provide the
> > supported vpd pages that are there. I do have some nvme data though
> > from a sosreport. I'll send you that in a separate email.
>
> The device vendor should be fixing their firmware to report a suitable
> set of DMRL/DMRSL/DMSL values which align with the expected performance
> of the device.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
>

