Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A16EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 11:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjF2LTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 07:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjF2LTB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 07:19:01 -0400
X-Greylist: delayed 151 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 04:18:46 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212E358A;
        Thu, 29 Jun 2023 04:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688037340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VYQdV7ZcyvNvdsbYtp32vK3OuoGrKT3oKyb9DMC5ltJWbyp1qTBOnzZRiJPgMj0Sub
    T6TEX8zIVA/NhBdQ2OBMQAoPmKNpXpIQ48QJRTCWDj4dvFzlPs6m25HYhBLHIWxV265c
    j53y0KzEGz7iBkcWoPRhnJhA/WxZOJNumCdE2jZzvxk16Of6Zd4xtH9F2fIzcDpRHsIg
    pANy0NcARnO4uWoL59l9Nb8QHBhjhC2NxiHtzIJk2nut3LPcgnF11f7biBJadXWDd/No
    OdBu+NWsU5GafahaSsieEaD6h7zSiLOBviy8aw3krFWBjQTUs3w/m3921ejClZhKQtmv
    b44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688037340;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KWbwgCvZXfa2teNW2prW9YdrDNt/w708akfCWIJtKJU=;
    b=KOtRiTzMgUGIwX3JYqA7I0wYpz8BtfkiJeFChBmtY6kzIlbDi2X5vp/S/UbBxyppsR
    kwGecEqxTXx7jmJNumbpJS1RlYIcNP73V+gEAu7MQkzPGdrlOODXWoXXc3vK5tpXl6H/
    J3YRC1liiKFZ4rlcWmMrwJBXCUmfEcdvcb7bK/JFERnw6dTBKr/XWK8IEauX4AJIcdXG
    Wz4KgZO7i0/bf6mZMG3TlxAhJIeTafXyatasvy8P6lj7NdpWYG5+/Rwc5pLgDmjP/HMY
    Tc1w/vxA/iTZPfeUId3hVYlwGr/ZzX4bWzpFs8mMA78u66AusboU9eMgekZD5mjgue/U
    EXwg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688037340;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KWbwgCvZXfa2teNW2prW9YdrDNt/w708akfCWIJtKJU=;
    b=O/VN3GHY0AZuIYcUxTS8IbUTJsHP4lOBt+ZlGYF4VZR8zA35DUkjMPi4qGa5drvKkb
    Fpau1qkg5IH8sfVOqIgEbYFmiFFAds3jI5RVCBqIRrNuo4oMLP6aVwLw7zElJGYrtDOr
    DlYHyr2CigHeEp2+r98MR62WwxZcJXKWwaKehZ3mBEt6wWK1PXgZ+Em4IM0SoMQeof3L
    p3iRChUEUU7xu9sICJClH0P2bEdT/Xw+xpE5yikmV9QwYO0rz466QCSivMivwBpNtfx5
    +EJKB4HSggS9srB22sPtBAUUo11Gm8m2w23hzeeK7RWHXpfNNLZ3Y7sxzx9GArU2L5lw
    /3rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688037340;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=KWbwgCvZXfa2teNW2prW9YdrDNt/w708akfCWIJtKJU=;
    b=ZVTuPL391k43Nxex0r8hXvTI9EjNP44aN9nfbG8fJ8EKr/d52Qo0gTV2/FDA1KW5op
    /TmOyuY8RyoJseghklBQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfio0GngadwjQ4XxhRQEqUjscf3yiLTCTJODspA=="
Received: from [IPV6:2a02:8109:8980:4474:5850:ed97:4915:28a8]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z5TBFdmcz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 29 Jun 2023 13:15:39 +0200 (CEST)
Message-ID: <47902153-aa90-7901-c0d6-51d03804dafa@xenosoft.de>
Date:   Thu, 29 Jun 2023 13:15:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [FSL P50x0] [PASEMI] The Access to partitions on disks with an
 Amiga partition table doesn't work anymore after the block updates 2023-06-23
Content-Language: de-DE
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        schmitzmic@gmail.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Darren Stevens <darren@stevens-zone.net>
References: <024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de>
 <f1a0f2252cc38721e222530dc4026ed3834e3eb8.camel@physik.fu-berlin.de>
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <f1a0f2252cc38721e222530dc4026ed3834e3eb8.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Adrian,

On 29 June 2023 at 12:17 pm, John Paul Adrian Glaubitz wrote:
> What version of AmigaOS is that?
AmigaOS 4.1
> Maybe the RDB is corrupted? Did you try on a freshly created RDB?
Good idea! I recreated the RDB with the Media Toolbox on the 
sb600sata.device, 0. (AmigaOne X1000)

Unfortunately, it doesn't solve the issue.
> That can be done with just "git revert <commit hash>".
I know but I prefer my own patch because sometimes I can't revert the 
commit anymore because of dependencies.

Thanks,
Christian
