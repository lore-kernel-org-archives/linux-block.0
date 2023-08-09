Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966BCC0015E
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 21:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjHIVkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHIVkK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 17:40:10 -0400
X-Greylist: delayed 2402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 14:40:10 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589EA1BF7
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=SuYKXbiQSoXZEz5mfCg5gD/UnTQOyRLetjmCNaPirb0=;
        t=1691617210; x=1692826810; b=MhEMDH8GAQ3yhxRKvOG323w/caUifdk6aoS7d5C780wmnsi
        Zdum1UIajkG9EnfJmlIyPsAsmpv68ImSYD3qtzoDR/lrPwEzJBsZq6hyDUuKEEtB9inNOApkqaXUJ
        veVAbTfcGW4QgkeV+EVCrYKc9hjC0QKYB4cw+1B/WCj13rAbegGejkVbzYcTLXWIdjNfFBRfCD55+
        Hhw43yYHuTDidRuT4WzE4P3IBLj/DtLOeQaEwWbr4CJdfFQakhuxuopnzbTSL75Nw3cYP/Zvd6t1f
        JuAvWc3AV9op8j35F0+8lLBThekCnxLOXREQuY1FfRc5d8cH8cNA+8und3uc/ihA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qTqHU-00F7uX-2j;
        Wed, 09 Aug 2023 22:59:49 +0200
Message-ID: <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
Subject: Re: [PATCH net-next 03/10] genetlink: remove userhdr from struct
 genl_info
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
        jiri@resnulli.us, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, pshelar@ovn.org, jmaloy@redhat.com,
        ying.xue@windriver.com, jacob.e.keller@intel.com,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        dev@openvswitch.org, tipc-discussion@lists.sourceforge.net
Date:   Wed, 09 Aug 2023 22:59:47 +0200
In-Reply-To: <20230809182648.1816537-4-kuba@kernel.org>
References: <20230809182648.1816537-1-kuba@kernel.org>
         <20230809182648.1816537-4-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> Only three families use info->userhdr and fixed headers
> are discouraged for new families. So remove the pointer
> from struct genl_info to save some space. Compute
> the header pointer at runtime. Saved space will be used
> for a family pointer in later patches.

Seems fine to me, but I'm not sure I buy the rationale that it's for
saving space - it's a single pointer on the stack? I'd probably argue
the computation being pointless for basically everyone except for a
handful users?

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes
