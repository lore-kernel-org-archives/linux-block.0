Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0BBEB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 17:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFTRhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFTRhq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 13:37:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AC8F4;
        Tue, 20 Jun 2023 10:37:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D9611F390;
        Tue, 20 Jun 2023 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687282664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQMScDX/cvgFRjCGIqLHXDTtERLukXLjwnsLxfJ35pI=;
        b=rXYzckEAd/l0kJ6YfTeJZg+wCkmRdBLJw+hsF38Y+EoKp8QkwqmTXIGeD2ViXZfzTOTdEq
        8hTq2EbCpTiZB/mzgnd6hDcKITLPZ5Kifz6/BaILvMXYTFa+bIEBIw2Bb3e7fMXYWm7Cg7
        OvNH7suvloGx3Cywr5diI5eRlzlwlJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687282664;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQMScDX/cvgFRjCGIqLHXDTtERLukXLjwnsLxfJ35pI=;
        b=ns9MlZGHKJUhM/aNne/k5Ws/X7/tyzNRTdXuOac/x2eUDnoTTbJ0BAEtPmUfqYluuO+4dx
        8imqchkZwihWjsAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C5E21346D;
        Tue, 20 Jun 2023 17:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TYX+GejjkWSAMAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 17:37:44 +0000
Date:   Tue, 20 Jun 2023 19:37:43 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Message-ID: <f6rvvhgim4nk34onfgbwyfctgvgdbdigwbsugjvizgtli46p57@s7c4gkqrpjqy>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
 <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 20, 2023 at 04:49:45PM +0300, Sagi Grimberg wrote:
> > +nvmf_wait_for_queue_count() {
> > +	local subsys_name="$1"
> > +	local queue_count="$2"
> > +	local nvmedev
> > +
> > +	nvmedev=$(_find_nvme_dev "${subsys_name}")
> > +
> > +	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
> > +
> > +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> > +
> > +	queue_count=$((queue_count + 1))
> > +	if grep -q "${queue_count}" "${queue_count_file}"; then
> > +		return 0
> > +	fi
> > +
> > +	echo "expected queue count ${queue_count} not set"
> > +	return 1
> > +}
> > +
> >   set_nvmet_attr_qid_max() {
> >   	local nvmet_subsystem="$1"
> >   	local qid_max="$2"
> > @@ -56,10 +76,7 @@ set_qid_max() {
> >   	local qid_max="$3"
> >   	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> > -
> > -	# Setting qid_max forces a disconnect and the reconntect attempt starts
> > -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
> > -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> > +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1
> 
> Why not simply wait for live? The connecting is obviously racy...

That is what the new version is doing. It's waiting for the live state and then
checks the queue count.
