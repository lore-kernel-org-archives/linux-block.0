Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDDDEB64DD
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 09:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjGEJLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjGEJLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 05:11:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187C10D5
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 02:11:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E5EC22422;
        Wed,  5 Jul 2023 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688548300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUx+G9Ikc1JcrkULELUyJhcCdeD93Kd+JwIOZOQVEPo=;
        b=wqN58WNBWlHAO9OXbYJtpheItBWrHWGwEo47PaYvozDMyFfbXNwxDC4QeKrufVG+qoba3k
        da0adc/jyMLYjS5pvcAWDq2HmZlISTg7JHfAnstLV3/ELZDHdBPFKfuicwwRWWn6Ig3135
        CZrMF2ezCKXl+sbd2oPgorEAi6QtDwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688548300;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QUx+G9Ikc1JcrkULELUyJhcCdeD93Kd+JwIOZOQVEPo=;
        b=bQmoS0BDHSY+2qmHWf9lVBW6yHNjkSodYRrXPggyZl2wCfBRkiza0vH/bRoA2qTAOewIDX
        YmPVwz7oYfDXLuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FBAF134F3;
        Wed,  5 Jul 2023 09:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UChrE8wzpWTaZAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 05 Jul 2023 09:11:40 +0000
Date:   Wed, 5 Jul 2023 11:11:39 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Message-ID: <4rzx7tets37h3tifirq3i63nh5n45cbmiu4xdwvoojhdmqquv2@rwnidq3hbuwg>
References: <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <lfwwdbrtexufmsjbrw5j36jay2m56kdnuzwcrmcwnickzmgb4i@b5d32kl3oaps>
 <zftdt4pmjiwnbkje2zpl2kp5oraapsrawpbwf3l5qppmegpylj@so52n3f5zd6u>
 <l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l7vk7fnzltpmvkwujsbf2btrzip6wh7ug62iwa3totqcda25l6@siqx7tj6lt3l>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 30, 2023 at 08:48:55AM +0000, Shinichiro Kawasaki wrote:
> diff --git a/fabrics.c b/fabrics.c
> index ac240cad..2eeea48c 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -677,6 +677,26 @@ static int nvme_read_volatile_config(nvme_root_t r)
>  	return ret;
>  }
>  
> +char *nvmf_hostid_from_hostnqn(const char *hostnqn)
> +{
> +	const char *uuid;
> +	const char *hostid_from_file;
> +
> +	if (!hostnqn)
> +		return NULL;
> +
> +	uuid = strstr(hostnqn, "uuid:");
> +	if (!uuid)
> +		return NULL;
> +	uuid += strlen("uuid:");
> +
> +	hostid_from_file = nvmf_hostid_from_file();
> +	if (hostid_from_file && strcmp(uuid, hostid_from_file))
> +		fprintf(stderr, "warning: use generated hostid instead of hostid file\n");
> +
> +	return strdup(uuid);
> +}

Maybe we should move the check after ...


>  int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>  {
>  	char *subsysnqn = NVME_DISC_SUBSYS_NAME;
> @@ -753,8 +773,10 @@ int nvmf_discover(const char *desc, int argc, char **argv, bool connect)
>  	hostid_arg = hostid;
>  	if (!hostnqn)
>  		hostnqn = hnqn = nvmf_hostnqn_from_file();
> -	if (!hostnqn)
> +	if (!hostnqn) {
>  		hostnqn = hnqn = nvmf_hostnqn_generate();
> +		hostid = hid = nvmf_hostid_from_hostnqn(hostnqn);
> +	}
>  	if (!hostid)
>  		hostid = hid = nvmf_hostid_from_file();

... here so that we also catch the case when the /etc/nvme/hostnqn and /etc/nvme/hostid
do not match
