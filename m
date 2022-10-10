Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32536C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 08:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJJItb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJJIta (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 04:49:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096D6525A
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 01:49:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B041218A8;
        Mon, 10 Oct 2022 08:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665391768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRHQljv6X517H4MqoQc1rATj5lPe2O/OCT3sVmf2+tU=;
        b=rYoaL6INHAxmIREd+g3HRAYTChcFJtPdYDKkuCfG6264Xssme355f4AB51D4/jZtBXP0Rh
        2ItrtCCrTOWz7AdpyQp8LOyf4Ve+joPP7Obsogkz87DnwfzGIClFd4Wj0v9F2kSoJfH71M
        v42F/fPWlEI5QGftFGXs0yUfsHekQYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665391768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VRHQljv6X517H4MqoQc1rATj5lPe2O/OCT3sVmf2+tU=;
        b=s8ZAjv8jJwh2ReX9Er8cCwy/E2aYB8UnD4NON/qkliogoTOUDpkv0Go8YxleHv2UlOQXx2
        Kxlu9gJ72PG/RuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5841413479;
        Mon, 10 Oct 2022 08:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id juWBFZjcQ2OXeAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 10 Oct 2022 08:49:28 +0000
Date:   Mon, 10 Oct 2022 10:49:27 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] block: fix leaking minors of hidden disks
Message-ID: <20221010084927.47nniioysahndy6n@carbon.lan>
References: <20221007193825.4058951-1-kbusch@meta.com>
 <Y0PLerK6pBp9UC2G@infradead.org>
 <20221010080218.uqhkvryiipybxidd@carbon.lan>
 <20221010081902.GA23270@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010081902.GA23270@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 10:19:02AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 10, 2022 at 10:02:18AM +0200, Daniel Wagner wrote:
> > Doesn't give me the same consistent result as with Keith's version:
> 
> That's because it is broken..  Try this version:

This version works.

Tested-by: Daniel Wagner <dwagner@suse.de>

# ls -l /dev/nvme*
crw------- 1 root root  10, 124 Oct 10 10:47 /dev/nvme-fabrics
crw------- 1 root root 243,   0 Oct 10 10:46 /dev/nvme0
brw-rw---- 1 root disk 259,   0 Oct 10 10:46 /dev/nvme0n1
crw------- 1 root root 243,   2 Oct 10 10:48 /dev/nvme2
brw-rw---- 1 root disk 259,   2 Oct 10 10:48 /dev/nvme2n1
brw-rw---- 1 root disk 259,   3 Oct 10 10:48 /dev/nvme2n1p1
brw-rw---- 1 root disk 259,   5 Oct 10 10:48 /dev/nvme2n2
brw-rw---- 1 root disk 259,   7 Oct 10 10:48 /dev/nvme2n3
brw-rw---- 1 root disk 259,   9 Oct 10 10:48 /dev/nvme2n4
crw------- 1 root root 243,   3 Oct 10 10:48 /dev/nvme3
crw------- 1 root root 243,   4 Oct 10 10:48 /dev/nvme4
crw------- 1 root root 243,   5 Oct 10 10:48 /dev/nvme5
# nvme disconnect-all
# nvme connect-all
# ls -l /dev/nvme*
crw------- 1 root root  10, 124 Oct 10 10:47 /dev/nvme-fabrics
crw------- 1 root root 243,   0 Oct 10 10:46 /dev/nvme0
brw-rw---- 1 root disk 259,   0 Oct 10 10:46 /dev/nvme0n1
crw------- 1 root root 243,   2 Oct 10 10:48 /dev/nvme2
brw-rw---- 1 root disk 259,   2 Oct 10 10:48 /dev/nvme2n1
brw-rw---- 1 root disk 259,   3 Oct 10 10:48 /dev/nvme2n1p1
brw-rw---- 1 root disk 259,   5 Oct 10 10:48 /dev/nvme2n2
brw-rw---- 1 root disk 259,   7 Oct 10 10:48 /dev/nvme2n3
brw-rw---- 1 root disk 259,   9 Oct 10 10:48 /dev/nvme2n4
crw------- 1 root root 243,   3 Oct 10 10:48 /dev/nvme3
crw------- 1 root root 243,   4 Oct 10 10:48 /dev/nvme4
crw------- 1 root root 243,   5 Oct 10 10:48 /dev/nvme5
