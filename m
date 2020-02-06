Return-Path: <SRS0=DGx4=32=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A05C35247
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 02:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F3920730
	for <linux-block@archiver.kernel.org>; Thu,  6 Feb 2020 02:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1FHeMjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgBFCBU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:01:20 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45785 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFCBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Feb 2020 21:01:20 -0500
Received: by mail-oi1-f181.google.com with SMTP id v19so2958564oic.12
        for <linux-block@vger.kernel.org>; Wed, 05 Feb 2020 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WoPzmJ3QiLukxuz6DKVAzU9gkGfQvjuixc6cO7WUQs8=;
        b=O1FHeMjXFSOILkBhHrqEIP2lloqCDyljt2qWbzTWoX+uBjRnfdWo3oPegsw2eoPan6
         C1NLVglsuhNd1TronEiTXa8IICi9/V4PByBGHmEuNGeHmt9+cUYfNiSyeugbj18T4X4A
         lRe5MoBgIUk0+uaSX5xvUCgK+EVAe+jADuogGP2GHgtyo/nbgmoC/pW8mJJU+ywdmj/F
         lI1I4X9/9TTjl7Eaho/qKRP/NtF9jWiBZr/lonWGDfCJqOA60V4VEBRwnMlGqkxrkzGG
         PyXyJlZAcepKi1F2fZXKQqdFr4cNvynX/17fdOYKXmqCQYftQVeTRTsPUq11KwDC7zk7
         8/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoPzmJ3QiLukxuz6DKVAzU9gkGfQvjuixc6cO7WUQs8=;
        b=dFqZwhH63o+X1GXV25s4HiZFGPPOoPLDtM5Fe6vXd5R7ta4h2Z8AWXtF74DevMBYsm
         CdsVm35/GKh4qUBeznxviHsJ6LkwnysdqHVMAN9//io4iYtW1ES0PSyZCMXUi3QtY4lN
         xf3jR8QSe6yBYAppvVN2GzNPdsoyFNPyuxoBhFoxb8mdEbfx19LjP5yeHl6a8cEzizX1
         rsH/P1rqowT1X3CM/Zv8FGgEpxakZQTFykEzQycs76d0FRqxPg/Cei+DOJktXICtuDPE
         gRlJ+2kUJXZsC4Uw0wQRBMC1syq9LfFcaCBJJirIDzLJHwghiVO0ZMw1ouvs+sZsaqrb
         iUug==
X-Gm-Message-State: APjAAAXKDBwy7IgeN2XjuiSZZlIAZbC7MJ/vonn+gE1woHB+OHvZURak
        9d9HEOgMx2blLQW3IhhB8rwRtabKdOmGp1GJg9g=
X-Google-Smtp-Source: APXvYqwPCFurz3YyKrpkaq4DkukAB2tyaYOJcBv1yDVNU4UlufXNyzAfxVRXjSE12gtubDBYLnM/JK9+xukQ15VnOBI=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr5556426oiy.170.1580954479470;
 Wed, 05 Feb 2020 18:01:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+qeAOqyL5fDoFUXxVD0iaYSpY9P1qNH0Hd7eUUyGCg6hznKRQ@mail.gmail.com>
 <CA+qeAOpn85PevU6yxKqyt358ZVhdmLfwdaxvcpi4vy32Y4u8Mg@mail.gmail.com>
In-Reply-To: <CA+qeAOpn85PevU6yxKqyt358ZVhdmLfwdaxvcpi4vy32Y4u8Mg@mail.gmail.com>
From:   Dongsheng Yang <dongsheng081251@gmail.com>
Date:   Thu, 6 Feb 2020 10:01:07 +0800
Message-ID: <CA+qeAOoXShFs5u7JUpCSs0vV9LEkY++zLmaez8CWvZbDcD_VSQ@mail.gmail.com>
Subject: Fwd: Bug Report : meet an unexcepted WFBitMapS status after
 restarting the primary
To:     lars.ellenberg@linbit.com, philipp.reisner@linbit.com,
        joel.colledge@linbit.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com
Cc:     duan.zhang@easystack.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adding linux-block maillist......

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongsheng Yang <dongsheng081251@gmail.=
com>
Date: 2020=E5=B9=B42=E6=9C=886=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=
=889:44
Subject: Fwd: Bug Report : meet an unexcepted WFBitMapS status after
restarting the primary
To: <lars.ellenberg@linbit.com>, <philipp.reisner@linbit.com>,
<linux-block@vger.kernel.org>, <joel.colledge@linbit.com>,
<drbd-dev@lists.linbit.com>
Cc: <duan.zhang@easystack.cn>


Hi Philipp and Lars,
     Any suggestions?

Thanx
---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Dongsheng Yang <dongsheng081251@gmail.=
com>
Date: 2020=E5=B9=B42=E6=9C=885=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=
=887:06
Subject: Bug Report : meet an unexcepted WFBitMapS status after
restarting the primary
To: <joel.colledge@linbit.com>
Cc: <drbd-dev@lists.linbit.com>, <duan.zhang@easystack.cn>


Hi guys,

Version: drbd-9.0.21-1

Layout: drbd.res within 3 nodes -- node-1(Secondary), node-2(Primary),
node-3(Secondary)

Description:
a.reboot node-2 when cluster is working.
b.re-up the drbd.res on node-2 after it restarted.
c.an expected resync from node-3 to node-2 happens. When the resync is
done, however,
  node-1 raises an unexpected WFBitMapS repl status and can't recover
to normal anymore.

Status output:

node-1: drbdadm status

drbd6 role:Secondary

disk:UpToDate

hotspare connection:Connecting

node-2 role:Primary

replication:WFBitMapS peer-disk:Consistent

node-3 role:Secondary

peer-disk:UpToDate


node-2: drbdadm status

drbd6 role:Primary

disk:UpToDate

hotspare connection:Connecting

node-1 role:Secondary

peer-disk:UpToDate

node-3 role:Secondary

peer-disk:UpToDate

I assume that there is a process sequence below according to my source
code version:
node-1                                           node-2
                                            node-3
        restarted with CRASHED_PRIMARY
        start sync with node-3 as target
   start sync with node-2 as source
        =E2=80=A6                                                          =
      =E2=80=A6
                                                 end sync with node-3
                                            end sync with node-2
        w_after_state_change
                      loop 1 within for loop against node-1:(a)
receive_uuids10                                  send uuid with
UUID_FLAG_GOT_STABLE&CRASHED_PRIMARY to node-1
receive uuid of node-2 with CRASHED_PRIMARY      loop 2 within for
loop against node-3:
        clear  CRASHED_PRIMARY(b)
send uuid to node-2 with UUID_FLAG_RESYNC        receive uuids10
sync_handshake to SYNC_SOURCE_IF_BOTH_FAILED     sync_handshake to NO_SYNC
change repl state to WFBitMapS

The key problem is about the order of step(a) and step(b), that is,
node-2 sends the
unexpected  CRASHED_PRIMARY to node-1 though it's actually no longer a
crashed primary
after syncing with node-3.
So may I have the below questions:
a.Is this really a BUG or just an expected result?
b.If there's already a patch fix within the newest verion?
c.If there's some workaround method against this kind of unexcepted
status, since I really
  meet so many other problems like that :(
