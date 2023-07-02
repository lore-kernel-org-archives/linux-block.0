Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E247EEB64DA
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 04:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjGBEid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 00:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBEic (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 00:38:32 -0400
X-Greylist: delayed 78961 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Jul 2023 21:38:28 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DA7E68;
        Sat,  1 Jul 2023 21:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688272671; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Q3xxbHNLgiYO1j9SoBLgP+3qwIprT6rb3XUfA27sDAj1cu7TChidYbIzjygZKFqbkY
    K2moSEhhdJdT6ncuu1WZxx+vz6pZkYCsdb/42y4WheltTVQ2d8p1dEK+HzOLFs1sq0Oy
    7+CQCTRjsaYufO8gqvlHlUmcOWY3YrkY7Ixj7rDloTCae/0j0G1z9jy5Jj4mRd+Q+uqe
    lfZliQ6hZ7EwyqRnxKoKpB6/iGZa7pPnYVGTf4Np7X3AjZ+Co+4OVkurajp9Gb6xZtub
    ApyRaAnf/kykIR/DmyH0a5QAuoXmTrGv2uSxvVZzPaMljyjRzwix7EEIZjwaxZLQ9p7r
    bGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688272671;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Aj5gVXvZVhGLfUv4YXuWsU6+JuEoiU58JhJnWMbt9hc=;
    b=HEQdKFYS59tKHXic/2R4nUueTRko+P14DSW/6WEpb7h2t4gCCyJ4T76SqUPX0S0EUx
    RQ8feDAQ3rVMjDpZsr6Zlgpp3iBxHBVfnoHwTeL+lfbi3C7FcRySEBxo7c0ia0VhhnCN
    CMk0QAzscdYpDjpl+OuKtEa3aD06RNdUHJNGaYcqioIc62PlxpaFD9pCOHOSkx9esugj
    UOpuPR47efqLc2fM6mbX2SgAoVrv4OxqtCW6rxFZLR62hn+ix/t1m7qbNA8g4PV3ieHX
    QHgMoDtqHTC/kEPav1vphHa6hStOMuLVNIcPoxkO1OC3bKawHASvS0dOmErmylU1S6Sh
    tYBg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688272671;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Aj5gVXvZVhGLfUv4YXuWsU6+JuEoiU58JhJnWMbt9hc=;
    b=qKJS0/G/54GTyWrElTw0+myMf5sx8Tv3NurjcFR5a40EPWA0rtpJcJ9wLge2lR3A6O
    GpbweBpVqClHBZsTVupx+S5tBYr93VwNjVh0lqWpyf1oKB5eEvvwU0YZKgu/xivRpCZu
    Qqc74S0ehhV8fr5EytKbiXcr4OrrD1vjKEZaMzH3FZBBzYouIc9rQwv6jnEj9KOhKawH
    lXsQSrcHzo6tPowMz6bkIAeoHEcqn6nwsZei957KIvYYmo+YHjiz8/87R+/N4NLg8Hop
    Wb6x1Z3aYLvB6PeL0nldcj6f1grts874ZVM+mvvUgCM+1SkZ/SkIJIHgDCIinb61R4RW
    1oAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688272671;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Aj5gVXvZVhGLfUv4YXuWsU6+JuEoiU58JhJnWMbt9hc=;
    b=uDsAlMiUg3Nh7FS0StktKC57Nf3eif+3RgZBJEd6NBClfcyoFH9IE/pUhRsTN9fHSr
    pNwiT+NMwGNG6++dfaAg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfio0GngadwiD6N35t7Q4ijVgZcOIkYVMzjI4sw=="
Received: from [IPV6:2a02:8109:8980:4474:f1c7:b718:55a5:8b24]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z624botN4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 2 Jul 2023 06:37:50 +0200 (CEST)
Message-ID: <afc575b6-5f2d-f5cb-31d1-0830d0e369cf@xenosoft.de>
Date:   Sun, 2 Jul 2023 06:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, martin@lichtvoll.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
 <94d46446-97fc-9e92-2585-71c18e65b64a@gmail.com>
 <b9600d91-6a25-746e-0769-4d0e31038da5@xenosoft.de>
 <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02 July 2023 at 04:17 am, Michael Schmitz wrote:
>  I'm sorry to say I cannot see a new RDB partition bug her, just the 
> result of undefined behaviour due to overflowing a 32 bit nr_sect size 
> calculation in the old RDB code.
>
Hello Michael,

Thanks a lot for your explanation!

Actually, we need your patch because there is a very old bug but there 
are some endusers with RDB disks with Linux partitions. If I apply your 
patch to our kernels, then I need an enduser friendly solution for 
fixing the issue with their file systems.

Do you have a solution for the enduser (consumer)? How can they fix 
their file systems? The next issue is, if an enduser uses an old 
unpatched kernel with a partition, created with a new patched kernel. I 
don't know how can I handle this issue in the consumer support.

I can't help all endusers and some are not active in forums etc.

Thanks,
Christian
