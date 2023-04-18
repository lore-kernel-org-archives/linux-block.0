Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1CC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 14:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDRO0b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDRO0a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 10:26:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FDA183;
        Tue, 18 Apr 2023 07:26:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6550C21A97;
        Tue, 18 Apr 2023 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681827987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnQHzRr0LZD/gqua06NrEUO3XOVObpoFGxZ813nFw+8=;
        b=U48JVbzbUzPtUcReF2MIZHKVGHSSHDpQscfCDfNI5InpsGA7r48mpHWiQFudHm40r2Smrt
        Gi9AiRAIZNnz8mzPrjRKMFk+m68EkeKcZ9WDNpcALmgVrs3R+jKOu5hzIm76eHbSbdZWyU
        DCCzUmM6sAyFVZerVLZ8dunMxb/GgIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681827987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bnQHzRr0LZD/gqua06NrEUO3XOVObpoFGxZ813nFw+8=;
        b=hg4mAQJuxINaFtIAUcsYNVqGdl2aYVpMtTjEvkH6rGyXCBgBwQYSykzxiuQnwn0nF0X82k
        kMINp1OZTs6lwIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 561AF13581;
        Tue, 18 Apr 2023 14:26:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XzcBFZOoPmRRWwAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 14:26:27 +0000
Date:   Tue, 18 Apr 2023 16:26:26 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Message-ID: <lum3oejitdb36ox2ec736kc73hzlmmnyr7jtg23wfa4t5slkvs@hm4u6xfnatcp>
References: <20230418130159.11075-1-dwagner@suse.de>
 <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:43:22PM +0200, Daniel Wagner wrote:
> On Tue, Apr 18, 2023 at 03:01:55PM +0200, Daniel Wagner wrote:
> > nvme/041 (Create authenticated connections)                  [failed]
> > nvme/042 (Test dhchap key types for authenticated connections) [failed]
> > nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
> > nvme/044 (Test bi-directional authentication)                [failed]
> > nvme/045 (Test re-authentication)                            [passed]
> 
> I suppose these should be disabled for fc as all this is tcp specific.

After a fresh reboot the deleter tport, lport and rport trouble is back...

nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.265s  ...  10.365s
tests/nvme/rc: line 198: /sys/class/fcloop/ctl/del_target_port: No such file or directory
tests/nvme/rc: line 190: /sys/class/fcloop/ctl/del_local_port: No such file or directory
tests/nvme/rc: line 182: /sys/class/fcloop/ctl/del_remote_port: No such file or directory
