Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBA7EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 29 Jun 2023 07:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjF2Hl3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjF2Hkp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 03:40:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896B3A98
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 00:40:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15E002187E;
        Thu, 29 Jun 2023 07:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688024409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LwmfJfCWW+aPRMGHTIFX9CspErEDt1Wu6q7oGKDl6Gc=;
        b=gd3ToJVQPGvQFdK9ZDy8cY80HS6vY40C52WUQsTS3CXDH4/Z6IX/pTDN2yMpWitmqiqm3W
        PzTMVMf2uWAT2kHXJAmchh3PntA2vIPEK8VLNEKzRukcjEvqrYd0neih0GCi10mAVxCxEg
        jxmH2paUzimWDEKMHZVoi/7flQ6C/ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688024409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LwmfJfCWW+aPRMGHTIFX9CspErEDt1Wu6q7oGKDl6Gc=;
        b=XkCFfbVDoHoTACV9h+MQel4lDZG+KlupnEY0y/6fYB9TFJqpeRgNg8WnioezO18LDNBZTJ
        gpkCv8tdlxNFhEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0851F13905;
        Thu, 29 Jun 2023 07:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5/bxAVk1nWS3RQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 29 Jun 2023 07:40:09 +0000
Date:   Thu, 29 Jun 2023 09:40:08 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Message-ID: <zftdt4pmjiwnbkje2zpl2kp5oraapsrawpbwf3l5qppmegpylj@so52n3f5zd6u>
References: <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <lfwwdbrtexufmsjbrw5j36jay2m56kdnuzwcrmcwnickzmgb4i@b5d32kl3oaps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lfwwdbrtexufmsjbrw5j36jay2m56kdnuzwcrmcwnickzmgb4i@b5d32kl3oaps>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 28, 2023 at 08:25:24AM +0000, Shinichiro Kawasaki wrote:
> I looked in nvme-cli code. When it generates hostnqn, it does not set hostid.
> A quick dirty patch below for nvme-cli avoided the failures for nvme_trtype=loop
> condition. If this is the fix approach, the kernel commit will need
> corresponding change in the nvme-cli side.
> 
> 
> diff --git a/fabrics.c b/fabrics.c
> index ac240cad..f1981206 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -753,8 +753,13 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>  	hostid_arg = hostid;
>  	if (!hostnqn)
>  		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn)
> +	if (!hostnqn) {
> +		char *uuid;
>  		hostnqn = hnqn = nvmf_hostnqn_generate();
> +		uuid = strstr(hostnqn, "uuid:");
> +		if (uuid)
> +			hostid = hid = strdup(uuid + strlen("uuid:"));
> +	}
>  	if (!hostid)
>  		hostid = hid = nvmf_hostid_from_file();
>  	h = nvme_lookup_host(r, hostnqn, hostid);
> @@ -966,8 +971,13 @@ int nvmf_connect(const char *desc, int argc, char **argv)
>  
>  	if (!hostnqn)
>  		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn)
> +	if (!hostnqn) {
> +		char *uuid;
>  		hostnqn = hnqn = nvmf_hostnqn_generate();
> +		uuid = strstr(hostnqn, "uuid:");
> +		if (uuid)
> +			hostid = hid = strdup(uuid + strlen("uuid:"));
> +	}
>  	if (!hostid)
>  		hostid = hid = nvmf_hostid_from_file();
>  	h = nvme_lookup_host(r, hostnqn, hostid);

Looks reasonable. Though I would propably also add a warning iff
nvmf_hostid_from_file() does return a not matching hostid.
