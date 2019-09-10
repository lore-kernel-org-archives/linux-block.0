Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73C5C49ED8
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 15:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7996D206A5
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 15:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfIJP4x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfIJP4x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 11:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6D25301899A;
        Tue, 10 Sep 2019 15:56:53 +0000 (UTC)
Received: from [10.10.120.129] (ovpn-120-129.rdu2.redhat.com [10.10.120.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5B2219C4F;
        Tue, 10 Sep 2019 15:56:52 +0000 (UTC)
Subject: Re: [PATCH] nbd: remove the duplicated code
To:     xiubli@redhat.com, josef@toxicpanda.com, axboe@kernel.dk
References: <20190910063608.10081-1-xiubli@redhat.com>
Cc:     linux-block@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D77C7C4.9000306@redhat.com>
Date:   Tue, 10 Sep 2019 10:56:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190910063608.10081-1-xiubli@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 10 Sep 2019 15:56:53 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/10/2019 01:36 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The followed code will do the same check, and this part is redandant.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  drivers/block/nbd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 478aa86fc1f2..8c10ab51a086 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1046,9 +1046,6 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>  	for (i = 0; i < config->num_connections; i++) {
>  		struct nbd_sock *nsock = config->socks[i];
>  
> -		if (!nsock->dead)
> -			continue;
> -

Was this check to used to speed up reconnects? For example, if a send
was stuck waiting on socket memory to free up in the network layer, then
the above check would allow us to skip past those sockets without having
to wait on the socket that was trying to send.



>  		mutex_lock(&nsock->tx_lock);
>  		if (!nsock->dead) {
>  			mutex_unlock(&nsock->tx_lock);
> 

