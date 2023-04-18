Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D471C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 02:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDRCSD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Apr 2023 22:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDRCSC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 22:18:02 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CED3C10
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 19:17:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8AFD25828AA;
        Mon, 17 Apr 2023 22:17:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 17 Apr 2023 22:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681784272; x=1681784872; bh=F3
        gwOs5yZ09ScguDMjDgLq/mG1QfFQkfqrF7Mazy/tQ=; b=ev8PFUk1g/X+m6yY7b
        yF1/gOiLxzYOI7zajEx5zsek1CaxBvaHJx4pRjcY5s6quCMfk3u9Q4uugRRlVeNI
        m7917LE2AUFKA8ctb89vpKD82lEBILJksKuUzfp7OY28DQfPlLGzYItd/KHgHXhL
        ho12jny+sxo7nxhXda2g/6QciNNIxreiMKSsS7HoQmPkQrRQgUr9sIq/Ym38kAEk
        hm0QdcvRy9EQFS/MbAsIqjowi+pk3db7Sv1A5H2CNPx9mfdmrP0agffTUIV9Od4B
        eklv3KT3UsXOUNY+iYmQq8kEEirpnOnkRpbX28wXoHxzH0hSUG0t+do5vd+UpJYS
        i6+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm3; t=1681784272; x=1681784872; bh=F3g
        wOs5yZ09ScguDMjDgLq/mG1QfFQkfqrF7Mazy/tQ=; b=Z1ZtL9rSnbkP4cfLdTe
        J+yKVOJo7R39npGanpuXIMFUG0kdiXxkta0jTqcNMYqwK0CpKIdMglCIL5BvToQj
        SX4cUCHnfeIZS8IePo9Nv2lt9UhFbZuiLidczPTwDOEvcJdN6S+Vdg18Vmu04vMQ
        fquXBIyGxXPpvfhh13b4DQ/nW5DLGrcoZYNmf1g2j9ikAWiHk1d+3Nu24o2Yg2hZ
        faR90NSkF+fIcToMQSGJZMmjd9HqiU2ZPixYztQfe0mlpkZpncQDW6VUXP+3H32u
        4uCGC4EILSfKueg7Oo8E11bdbs9ykrql1gQmAngsPeLAD7AfQzcbU63Qjnp3Eh/Y
        DFg==
X-ME-Sender: <xms:0P09ZJUgQ-dSQgzP0mwltSh8WD2k0rWTH7XwOZ1fVGiLyCwQ5-HV6g>
    <xme:0P09ZJnZLE4N2oegFeVlS4_yeImlNzZD8bxAPuza8Gn63eSAcIYA-cZtXciYfVaKA
    xb90fXVD2ATMQVZTC8>
X-ME-Received: <xmr:0P09ZFZ0BNMmVSEfqMMzBAhX63rnqX0HfhAbVaiI4DApezqSTuaYcDiThCZunHjHF-fXSo4YzPNPjMtXysnkpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeljedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    fstddttddvnecuhfhrohhmpefuhhhinhdkihgthhhirhhoucfmrgifrghsrghkihcuoehs
    hhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dvgedtgfdvhffgkedvkedtgfefleejleeggfekudejieetheeghfegtefhgfehheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhinhhitg
    hhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0P09ZMU4lvHxLck3DorXKCQarj5tvNnBP8E0AtB41IDikC-CTUfxPw>
    <xmx:0P09ZDnu1juapsyUXQyzJtbySB8J361xXetIRvM2Jz5KcWllDveWrw>
    <xmx:0P09ZJdA_R9NbeRJbLEPiMwKB8loFgWbpofH0J3sPA5rwPsT31iitQ>
    <xmx:0P09ZIwpssZXYOmQEr6wM83c5VHL2i0HSFkSs0gVf_BYb9eltbRkI0F1SVQ>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 22:17:50 -0400 (EDT)
Date:   Tue, 18 Apr 2023 11:17:46 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     alan.adamson@oracle.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] nvme/039: avoid failure by error message rate
 limit
Message-ID: <26coaxpjtu5vkzxp6tp6wysbzydvg7mjptudbwnxl3xthzxdh7@kl32wqat4z6k>
References: <20230412085923.1616977-1-shinichiro@fastmail.com>
 <34019736-06eb-b5dd-b6a1-101907c38917@oracle.com>
 <saejpr554r5sxjhqjps3yqgdwhrgufauki2f5npp2yzu6xtvum@q7oz2nwzic3r>
 <lhy27pg5my4fw7a7lyt5ag6zms4vnnaoab2laylatjqwkckdzv@55ebsbgtgpbs>
 <3216ff1f-ecde-967b-75b1-7da643570ed9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3216ff1f-ecde-967b-75b1-7da643570ed9@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 13, 2023 / 10:19, alan.adamson@oracle.com wrote:
[...]
> Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
> 
> Tested-by: Alan Adamson <alan.adamson@oracle.com>

Thanks for the review and the test. I've applied the fix.
