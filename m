Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221CC77B7C
	for <linux-block@archiver.kernel.org>; Thu, 11 May 2023 07:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjEKHII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 May 2023 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbjEKHHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2023 03:07:44 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B023F76A0
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:07:41 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-55c939fb24dso76329027b3.2
        for <linux-block@vger.kernel.org>; Thu, 11 May 2023 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683788861; x=1686380861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNfHxr4G/JrLUZZ6MRKxmP6K5eN8DLy2NxSaxhT7fow=;
        b=pZ6dwW3g3vD/gyjGwp+h6kPCy+pGuV6NiUU1NDODeoM8VLeFz/Z2mhpWDjnN2RFhSq
         1DSSLk66vJAkveL55yMkWDRmdnoD1Am278E5qw7QqopFUFa2yrOSq+vWZqXH3/ryL3Qr
         sD16FURh+ncBgfNcOMN4cMafv5JqVIdWBUQx03W3f1RQyYWAFrVk05mf3THwjg7loXqL
         XWPqxLMLAzUnSt1njfWuZyGI+2YfatcDaIU6wI7hbNwlZCm9vvuCg4SqSLb14st1TGSl
         Wft58J9o0CRFlveKeEdCFsl9NLT9b+M1jqLgM8L8Gh6ttuwCwSveY5IRtuwA+8qgBmWH
         xJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788861; x=1686380861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNfHxr4G/JrLUZZ6MRKxmP6K5eN8DLy2NxSaxhT7fow=;
        b=jIXbm73YmD2u/9cYtn7EEa3g996dHZnCCq/cq45pZ/m3D+fF7vwKYuxJTEPH8IXmwe
         7SYHUIDZsJEr7d14vvsNqmXUU0YtK1e84OmgVcJXT2V9GHLgfnZITEhg5elVDsLxXE/a
         kAQ/3PH8+NmDTYQCvcFyhglMMpZhCx17xh8LUrQ5eATMOOVlfEOOc1clYGRAnHMjDC1L
         uc8fOR3pPQTgOJuU0DdwHv0xwkart4omcVtkI9tsyKx4aAfdGw2UOvDROhfecrxnPEsS
         fVuULixXKdKzVCTPC4y3d/hD+EKxEAXuXnIegMFco3xQPWCne/D6aOjf/fh8WufDZ07u
         urXQ==
X-Gm-Message-State: AC+VfDz6r4MWsYlUFnUKSsjsiPzFlr3EReJMLiRXoUDhEyXCO2Ie/o/Q
        3hGuo2vHLd0BeyTff6OdR6HE1NHarsJsDv98j0+Nhw==
X-Google-Smtp-Source: ACHHUZ4ocNSahL3QY/b6Az3Vujho4WRHGib4IF7PWeo5VA5RT9/RGS+kkKXlWVSymqRb1NQcpP8aprojMXVUxdfwqfQ=
X-Received: by 2002:a81:8445:0:b0:55c:67df:6700 with SMTP id
 u66-20020a818445000000b0055c67df6700mr22328993ywf.19.1683788860623; Thu, 11
 May 2023 00:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a686ca05fb6584ea@google.com>
In-Reply-To: <000000000000a686ca05fb6584ea@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 11 May 2023 09:07:04 +0200
Message-ID: <CAG_fn=XUQUpt69a66i7XM9tHeQL96WnzNJ9X60OTm3ZB5=khZA@mail.gmail.com>
Subject: Re: [syzbot] upstream boot error: KMSAN: uninit-value in strlcat
To:     syzbot <syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 11, 2023 at 8:58=E2=80=AFAM syzbot
<syzbot+26836cb949db3d40c992@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    16a8829130ca nfs: fix another case of NULL/IS_ERR confusi=
o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10811e3428000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da7a1059074b7b=
dce
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D26836cb949db3d4=
0c992
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2

Sorry for the noise, I was trying to switch KMSAN bots to the upstream
tree (it is not ready yet, needs one more patch), and accidentally
sent this report to LKML. Please disregard it.
