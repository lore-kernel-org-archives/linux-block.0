Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4561EC35DF5
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 06:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1E2082F
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 06:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmua0/yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBYGcT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:32:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgBYGcT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 01:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582612337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eroig7D6vFEeaOGUxUXLrHwiaYEEbMGludUh5+B1tSI=;
        b=Pmua0/ycORQK/CVAnmhEFhH/JcEoy3y28QOfuyYyiHMCrVCiQiH1kYktdnihfhxamZHxZu
        VNh0lGK019ZWUokQLQWgAbwkJUafpGKzBoTb5FIkgSIAYycJ50ojBB/u3DXWWeK6lDfHrt
        UWGrkpUgod+eP2rWNwlsl8OLJMpA+xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-AzZP0QjNPPOpJYpRHPhvfw-1; Tue, 25 Feb 2020 01:32:15 -0500
X-MC-Unique: AzZP0QjNPPOpJYpRHPhvfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B56D8010CA;
        Tue, 25 Feb 2020 06:32:14 +0000 (UTC)
Received: from [10.10.124.80] (ovpn-124-80.rdu2.redhat.com [10.10.124.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96A681D6;
        Tue, 25 Feb 2020 06:32:13 +0000 (UTC)
Subject: Re: [PATCH 1/2] nbd: enable replace socket if only one connection is
 configured
To:     Hou Pu <houpu.main@gmail.com>, josef@toxicpanda.com,
        axboe@kernel.dk
References: <20200219063107.25550-1-houpu@bytedance.com>
 <20200219063107.25550-2-houpu@bytedance.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E54BF6C.4060309@redhat.com>
Date:   Tue, 25 Feb 2020 00:32:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20200219063107.25550-2-houpu@bytedance.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/19/2020 12:31 AM, Hou Pu wrote:
> Nbd server with multiple connections could be upgraded since
> 560bc4b (nbd: handle dead connections). But if only one conncection
> is configured, after we take down nbd server, all inflight IO
> would finally timeout and return error. We could requeue them
> like what we do with multiple connections and wait for new socket
> in submit path.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>
> ---
>  drivers/block/nbd.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 78181908f0df..8e348c9c49a4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -395,16 +395,19 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
>  	}
>  	config = nbd->config;
>  
> -	if (config->num_connections > 1) {
> +	if (config->num_connections > 1 ||
> +	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
>  		dev_err_ratelimited(nbd_to_dev(nbd),
>  				    "Connection timed out, retrying (%d/%d alive)\n",
>  				    atomic_read(&config->live_connections),
>  				    config->num_connections);
>  		/*
>  		 * Hooray we have more connections, requeue this IO, the submit
> -		 * path will put it on a real connection.
> +		 * path will put it on a real connection. Or if only one
> +		 * connection is configured, the submit path will wait util
> +		 * a new connection is reconfigured or util dead timeout.
>  		 */
> -		if (config->socks && config->num_connections > 1) {
> +		if (config->socks) {
>  			if (cmd->index < config->num_connections) {
>  				struct nbd_sock *nsock =
>  					config->socks[cmd->index];
> @@ -747,8 +750,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  				 * and let the timeout stuff handle resubmitting
>  				 * this request onto another connection.
>  				 */
> -				if (nbd_disconnected(config) ||
> -				    config->num_connections <= 1) {
> +				if (nbd_disconnected(config)) {

I think you need to update the comment right above this chunk. It still
mentions num_connections=1 working differently.


>  					cmd->status = BLK_STS_IOERR;
>  					goto out;
>  				}
> @@ -825,7 +827,7 @@ static int find_fallback(struct nbd_device *nbd, int index)
>  
>  	if (config->num_connections <= 1) {
>  		dev_err_ratelimited(disk_to_dev(nbd->disk),
> -				    "Attempted send on invalid socket\n");
> +				    "Dead connection, failed to find a fallback\n");
>  		return new_index;
>  	}
>  
> 

