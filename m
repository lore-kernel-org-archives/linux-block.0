Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEA4CD5490
	for <linux-block@archiver.kernel.org>; Tue, 19 Sep 2023 07:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjISHnb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjISHnb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Sep 2023 03:43:31 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Sep 2023 00:43:25 PDT
Received: from mail.leeswilly.pl (mail.leeswilly.pl [89.116.26.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786ABFC
        for <linux-block@vger.kernel.org>; Tue, 19 Sep 2023 00:43:25 -0700 (PDT)
Received: by mail.leeswilly.pl (Postfix, from userid 1001)
        id 888F17613A7; Tue, 19 Sep 2023 09:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leeswilly.pl; s=mail;
        t=1695108930; bh=qCQG4c3C0tvkuSSy6okg6Td4OKi9mrw7rI9pE9SwJ9g=;
        h=Date:From:To:Subject:From;
        b=I11l4fJg7VtqEPZiC7dZ3UOjIxN9csrlpaMXC8VvWvxi+oxn40/faamXC4DE2gKr0
         ya6nCeEHvUyvoOXC6pE66ghPbwpinICt/47Gb/d3TBGW6r2AEUPh55cCo8C2qd2V8Q
         tfNb0FQpLPE94tdMJnRKdoa8zuBfR9Dsx0ndoto2wAfOp6xDQ6g42RwbI6SeprEG41
         vwshrv7QEw3DXL1qn6tuhYdDZ5D1E8oBkYo5rxGDw+pL4iboXMb5y89rLPpC6I3zRr
         FLqJwreiuwkFA7GKpaSnaLHKJtpShGbxZo1c1tzJbhgT1/Lgdpf/v6KgEsiXfdCk/3
         YHOTyuz6CvoQQ==
Received: by mail.leeswilly.pl for <linux-block@vger.kernel.org>; Tue, 19 Sep 2023 07:35:17 GMT
Message-ID: <20230919084500-0.1.3z.bcj2.0.fwb00b742b@leeswilly.pl>
Date:   Tue, 19 Sep 2023 07:35:17 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leeswilly.pl>
To:     <linux-block@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leeswilly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Jakub Lemczak
