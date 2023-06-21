Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E4EEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 21 Jun 2023 12:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFUMqn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUMqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 08:46:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66553107;
        Wed, 21 Jun 2023 05:46:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 205E021AC4;
        Wed, 21 Jun 2023 12:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687351601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOqnsf4JTgard+CNqhYgPXINKh7Q8qdMJU5633e+nBM=;
        b=fwQOjPd7/G+CpK9ni1W7ie3R5W+7mrZgm5GSbpleKmGfQD0en8W0BziBVElKa5NEgnuVxC
        I0D/Kv5yDFG57YktGlcGZCVw41iZ9R4N4IlVz/thOu1hwi5Xurc4cxw50z8OsGo0ecX6Au
        KWAFDulYQV19/fIVyHy+aydRk2Ab9VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687351601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oOqnsf4JTgard+CNqhYgPXINKh7Q8qdMJU5633e+nBM=;
        b=CCcofopDQJy5eNfLe407xe6vbI1vbG7gSAcZclZaag5nMt8A2dbS5JaUJUSLluBGObdi87
        QGRIM2L9rJqZckDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F135E133E6;
        Wed, 21 Jun 2023 12:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pRkNODDxkmS/UwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 21 Jun 2023 12:46:40 +0000
Date:   Wed, 21 Jun 2023 14:47:43 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Niklas Cassel <niklas.cassel@wdc.com>, lkp@intel.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Hannes Reinecke <hare@suse.de>, oe-lkp@lists.linux.dev,
        Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Subject: Re: [LTP] [linux-next:master] [scsi] eca2040972:
 ltp.ioprio_set03.fail
Message-ID: <ZJLxbwCno-it2xBB@yuki>
References: <202306192248.1ece4c29-oliver.sang@intel.com>
 <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f22c1d-6b04-d193-57c9-8cad1c555e4b@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!
> > kernel test robot noticed "ltp.ioprio_set03.fail" on:
> 
> LTP maintainers,
> 
> Patches have been submitted to fix this issue. Were these patches applied ?

Looks like they are in, at least these two:

    ioprio: use ioprio.h kernel header if it exists
    ioprio: Use IOPRIO_PRIO_NUM to check prio range

And there does not seem to be anything ioprio related haning in the LTP
patchwork.

-- 
Cyril Hrubis
chrubis@suse.cz
