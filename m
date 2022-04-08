Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A1C433F5
	for <linux-block@archiver.kernel.org>; Fri,  8 Apr 2022 04:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiDHEop (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 00:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiDHEoo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 00:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CACC83891
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 21:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649392960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMoooqF53GZ23xCsKlQFvK1zXgNehgoBhcLdBNRgTXI=;
        b=WhxJSXweSfXxBhxMeCuECiigJj8krkseAO2o6T3+QcUWa/9dgYtRiqsK8MrWaG/ptbe33b
        D5CGkVal8xELfbARuUhlgblyZlm33ZCiVxEpXez1GLq+hm8Gp3xiW8DEAk1ivq2isMF9vx
        aemVVpbzu54EEtEOB9eeA7s9mE5zct8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-otWZoUpOM8ahzjK2bR0cBQ-1; Fri, 08 Apr 2022 00:42:39 -0400
X-MC-Unique: otWZoUpOM8ahzjK2bR0cBQ-1
Received: by mail-pj1-f69.google.com with SMTP id c11-20020a17090a4d0b00b001cab6569b8cso4086645pjg.5
        for <linux-block@vger.kernel.org>; Thu, 07 Apr 2022 21:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMoooqF53GZ23xCsKlQFvK1zXgNehgoBhcLdBNRgTXI=;
        b=a0P+4brUFv3TKTDOs0wRTQaWyjU8Qw5DyJoQZ39B2p55p9i8z/2mj6hMaTIMEI9SQr
         LcTZSkflz3T9VgESHXYHiWDaY6JYmU9DVXFTquDMaUkfO+rRB9Z/FcfAHpr9j89+Vd3l
         vV5oNp71bU5vlx9IG9TH3CdYCYBDEo0DsbHIt0yMgakKFEp3Fqd3bsU3FwZHIp/UcdCV
         rU/DHIM5hV3Eevb/2/ime0iwCtuc4cQvvJZ1hG39UClu+U50UC6EEVWN2BER5bYGm4G5
         DzLDUKtwAO80OpY7ly2EwIdv/wn8cLPS5+5f4d+gDATJX4OkbNdzwkeQ+lbpUyQfc6V1
         icQg==
X-Gm-Message-State: AOAM532b9kjYYxuBiEkoT/yodbX7WVxtgExy4p5b0+kx8/cHhbsTjqYT
        OdUeQfCgF1qao/XfY9gSzLHvNUusYRHbk/NdENLYY0NvShzjji8TnYNpNgl4kSd2dAMlxuL3A0S
        EjWje4R46kzx/844YB8k5KFFvShumb/F6D9TjfpM=
X-Received: by 2002:a17:902:da86:b0:154:522b:342d with SMTP id j6-20020a170902da8600b00154522b342dmr17425665plx.46.1649392958054;
        Thu, 07 Apr 2022 21:42:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy68BbPh/Xv3keTRCrOzhla6M/q1AAvzBllIKCdQXvf3xbmXklNY7ShbxXO9F8Zy8Y+rzxyt9BS/gEZ0vzwUlk=
X-Received: by 2002:a17:902:da86:b0:154:522b:342d with SMTP id
 j6-20020a170902da8600b00154522b342dmr17425650plx.46.1649392957758; Thu, 07
 Apr 2022 21:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQkDFs7bt5T=jHO0iZ0zUgvaPpYPf_n4s+URtQXqF2Mew@mail.gmail.com>
In-Reply-To: <CAJCQCtQkDFs7bt5T=jHO0iZ0zUgvaPpYPf_n4s+URtQXqF2Mew@mail.gmail.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 8 Apr 2022 12:42:25 +0800
Message-ID: <CAHj4cs8Mtv66ikMDTJYQ48spEvF8QYyoD0SrZPDKfgXarpp=dg@mail.gmail.com>
Subject: Re: 5.18-rc1 nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) DNR
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chris

This issue has been reported and you can find more info here.
https://lore.kernel.org/linux-nvme/F2ACCD82-052F-473F-9882-1703147FA662@oracle.com/T/#t

On Fri, Apr 8, 2022 at 11:41 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> Hi,
>
> I'm seeing this never before seen message in the journal, all in red
> text. This is kernel-5.18.0-0.rc1.20220406git3e732ebf7316ac8.19.fc37.x86_64
>
> Apr 07 21:26:30 fovo.local kernel: nvme nvme0: pci function 0000:03:00.0
> Apr 07 21:26:30 fovo.local kernel: nvme0: Admin Cmd(0x6), I/O Error
> (sct 0x0 / sc 0x2) DNR
> Apr 07 21:26:30 fovo.local kernel: nvme nvme0: 8/0/0 default/read/poll queues
> Apr 07 21:26:30 fovo.local kernel:  nvme0n1: p1 p2 p3 p4 p5
>
> 03:00.0 Non-Volatile memory controller [0108]: Toshiba Corporation XG6
> NVMe SSD Controller [1179:011a] (prog-if 02 [NVM Express])
>     Subsystem: Toshiba Corporation Device [1179:0001]
>
> This happens with every boot of this 5.18.0-rc1 kernel, no such
> message for any 5.17.x series kernel.
>
>
> --
> Chris Murphy
>


-- 
Best Regards,
  Yi Zhang

