Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36E9EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 08:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjFVIAJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFVH7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 03:59:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D61FDD;
        Thu, 22 Jun 2023 00:59:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5C94203F1;
        Thu, 22 Jun 2023 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687420776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8UtH7gU84fxdekvJY/AM16EfFJszLpCobK2E/vW70Y=;
        b=gig58Clv8nLaebHHBdCRN9rz1WvPzyoUwuoPpVS5A/HD2nGeiPZxJih6y25Uzmpt88xTtF
        4qiWdrFk+SuFZlmBZU0BcK8VK0TihG5Wp+b16oYClCHo6w9/bs2SbCaamPrtCwzm/1QPKj
        XXam6SrpvlW6owI2k+Hmw+pGdzOJ03Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687420776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y8UtH7gU84fxdekvJY/AM16EfFJszLpCobK2E/vW70Y=;
        b=zDtqdnK8vDwkTjG6Gw/Q8ahT5J51Ye9akvh733KFwsFJ9CFO61xgfAGFGUt4jIh63cuL5c
        0iZh/EnsAvw8GtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF3A13905;
        Thu, 22 Jun 2023 07:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Gvq7IWj/k2REcwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 22 Jun 2023 07:59:36 +0000
Date:   Thu, 22 Jun 2023 10:00:40 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        "lkp@intel.com" <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Christoph Hellwig <hch@lst.de>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
Message-ID: <ZJP_qPeJ37H4qhEN@yuki>
References: <202306192248.1ece4c29-oliver.sang@intel.com>
 <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
 <ZJLxbwCno-it2xBB@yuki>
 <ZJMYP/CCVviG6IMq@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMYP/CCVviG6IMq@x1-carbon>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!
> But... shouldn't the installed uapi headers match the running kernel?

Genearlly this is tough nut to crack. It's nearly impossible for headers
to actually match the running kernel in testing environments, since
quite often the testsuite is compiled beforehand and only retrieved,
since recompiling for each testrun is wasting too many cycles. I would
say that the best we can have is that UAPI headers shouldn't be newer
than running kernel.

-- 
Cyril Hrubis
chrubis@suse.cz
