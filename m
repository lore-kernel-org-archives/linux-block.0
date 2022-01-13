Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBD9C433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Jan 2022 03:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiAMDUC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232025AbiAMDT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 22:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642043998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jm5clb8xIHCpD5vaQkgGsXDJRBF8humGdGQtxPy4P88=;
        b=W0eKP+y9m2GdIMWAdG0B8hUIAwN4IedRtDidcUte/1NA4s4mqY6QrwuJDigLhXphaRePAS
        +BzYi9Q0b00u4jn2rSqB3gZK3/ZRstK8kSsNFlf+xKGutODPE9WAZworATYA/URBH4GZcl
        gYcnUY7RUrFlmJp8mHYE+QNrhCRM90A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-k5ZRzDjSOxuvH2jEk0jxPw-1; Wed, 12 Jan 2022 22:19:56 -0500
X-MC-Unique: k5ZRzDjSOxuvH2jEk0jxPw-1
Received: by mail-lf1-f71.google.com with SMTP id n7-20020a056512388700b0042a063bb38cso2987188lft.14
        for <linux-block@vger.kernel.org>; Wed, 12 Jan 2022 19:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jm5clb8xIHCpD5vaQkgGsXDJRBF8humGdGQtxPy4P88=;
        b=vYjh+geMtQE1UmaAgcwyy1h2mbedbhBZGugU5ctYjITuGqeEqCVtI5minItPPExf3R
         X1nRO09DSolGvLFTB7NIkj+Gx1kvK/0DtXtaecQg2TDHOIXNaT1MVZKO/3+JLmIHkSSz
         TkgQSmOpDoLZnPemUQV+Pbu7eIFLNKmC4Okh49UkKYjceXmRxGH5LTxbei7apCBwc1lf
         UIi+ufTMsBxazoJVMoHsghYwvaPjk5ze76kv5IRKTgS600zpaLD28UHnuo3NwNcS/wXK
         9CM4xhzXG08UANZyhHmuqlL67PA7iw36GVsmLOCeFIIg6gEO81ytt5R8c0MUbDLVEu/g
         h1Bg==
X-Gm-Message-State: AOAM533+o1gw9yvJ/AYd9P3Hy+HI+QksMPT28Lb2B8MVYgIt6d0d86gw
        d7MJ1pcsrmvPMu/3uZaaOIUlHGMf33ZcC6Tet8KhAtHhsuZCCT07cznWCTCDq53AjL7T74HHjid
        3+pFy0s3zuqjojU+ik/5maJE3VqvdAfpCr3dNS+E=
X-Received: by 2002:a2e:947:: with SMTP id 68mr1793928ljj.300.1642043995220;
        Wed, 12 Jan 2022 19:19:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5cHa/DU7QyIA+QmQtXpznmnfrd2+vdQCDxWpWS7tHq+wUGhwbB0Mc8Mc7keQjtAIC037LniGxAkqy5XbXWaM=
X-Received: by 2002:a2e:947:: with SMTP id 68mr1793905ljj.300.1642043994973;
 Wed, 12 Jan 2022 19:19:54 -0800 (PST)
MIME-Version: 1.0
References: <00000000000081b56205d54c6667@google.com>
In-Reply-To: <00000000000081b56205d54c6667@google.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Thu, 13 Jan 2022 11:19:44 +0800
Message-ID: <CAFj5m9LujfHUMv+DuCLUfrevPHuF1NxtMiu_-N-C0VTiY-KNbw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in srcu_invoke_callbacks
To:     syzbot <syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, Jens Axboe <axboe@kernel.dk>,
        bpf@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 11, 2022 at 7:03 PM syzbot
<syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3770333b3f8c Add linux-next specific files for 20220106
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=171aa4e3b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9eb40d9f910b474
> dashboard link: https://syzkaller.appspot.com/bug?extid=4f789823c1abc5accf13
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b08f53b00000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com

BTW, the report should be addressed by the patch:

https://lore.kernel.org/linux-block/20220111123401.520192-1-ming.lei@redhat.com/T/#u

Thanks,
Ming

