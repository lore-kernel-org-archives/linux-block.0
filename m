Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3272DC43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0752070D
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 06:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="toJImdxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCMGuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 02:50:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44044 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfCMGuw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 02:50:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id h34so811935pgh.11
        for <linux-block@vger.kernel.org>; Tue, 12 Mar 2019 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YCUQ0M7WGRXFFPFl6jHrTgBSnT4/Uw5N8YWG17Gnqa8=;
        b=toJImdxQZvRU3HjXJJS5AeKyfzneXJbvYfhFcR3XyqtslGRWat0cQbabT+8SRbYpLx
         VBQfADdoYtU5Dx6ALhaGiCu6NJKPlJDBxAQuL1T0R7SeHBzMawVagwJ8XG5E+JzkcKiN
         WB6urAOlvIVPwh6dTXXcze+K31F9XP8Hw8L+yPvOHf1NSo6YtNNbdmufeRig4YAECjqi
         aB16cxmLOCLNA4GZG4Tg4bu0mHP77jPNqn/GvKTRwVcKMcsZ2jriwoHMaYRXUyWijlPX
         auyz2RDtezuH0s4ox2/YnnrbVRmeqYLX8u0eCY0XT9bbgwqA/DcPW2vmhMURxvzCxOzY
         Eqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCUQ0M7WGRXFFPFl6jHrTgBSnT4/Uw5N8YWG17Gnqa8=;
        b=Chhe+gAF82nEvzAxmz2KScqPQ8SJN/iCCJwJgD6dPaAl8ts8aoOV/+iJJYPlUP7JFK
         SD3k6B7vYOQ7lkih5v4pECfW8qbusPkY1na7IBQ/AMv6L1Rh5dCBwPqzrp+Q5lbPjW6z
         GIYNOWfQz8dIC9WzjAsHnZPa5opKQ4TzCzk7/m9QNx9Ihv0pHSKn9H/bADReZF19/NTw
         2IbXeo2FEwH1cquNVRGE7DaeZSMnJ05Ylc8s7mWsPpFzM3+SUqYjenTUNJPweBRAr1SP
         Qa0eE8CLFF9q7fpqsrir9lqykthBNUfRrNIXCnYpVBs6Y4gI3WjTkcXQvEsUqNCb/S+e
         zpLA==
X-Gm-Message-State: APjAAAWnY3WFUSPd0rmU/xFedoUTykfYYoDYOY1UIeoY9DUOlcsdvnJB
        zh/sDf5Zgvlb4NhxsQKKdr3QmA==
X-Google-Smtp-Source: APXvYqz+lmaJSTX2zBRdednbRikRAJGGTbF95GG2AV5GF+ZGlsZApi34LF6GfV7bsoypCP19WrdZEQ==
X-Received: by 2002:a63:fe58:: with SMTP id x24mr38871399pgj.255.1552459850585;
        Tue, 12 Mar 2019 23:50:50 -0700 (PDT)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id f127sm1240347pfg.6.2019.03.12.23.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 23:50:49 -0700 (PDT)
Date:   Tue, 12 Mar 2019 23:50:47 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Liang <xiliang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests] Fix checking multiple modules error in
 _have_modules()
Message-ID: <20190313065047.GA11825@vader>
References: <20190313064105.7751-1-xiliang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313064105.7751-1-xiliang@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 13, 2019 at 02:41:05PM +0800, Xiao Liang wrote:

Thanks for the fix! A couple of comments below.

> Signed-off-by: Xiao Liang <xiliang@redhat.com>
> ---
>  common/rc      | 2 +-
>  tests/nvme/002 | 2 +-
>  tests/nvme/003 | 2 +-
>  tests/nvme/004 | 2 +-
>  tests/nvme/015 | 2 +-
>  tests/nvme/018 | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 0c354a2..282d137 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -33,7 +33,7 @@ _have_modules() {
>  	local module
>  
>  	for module in "$@"; do
> -		if ! modprobe -n -q "$1"; then
> +		if ! modprobe -n -q $module; then

This needs to be quoted. Please run `make check`.

>  			missing+=("$module")
>  		fi
>  	done
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index 0132ac0..106a5a8 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -10,7 +10,7 @@
>  DESCRIPTION="create many subsystems and test discovery"
>  
>  requires() {
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs

These changes should be a separate patch.

>  }
>  
>  test() {
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index f304071..c6b3d40 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -11,7 +11,7 @@ DESCRIPTION="test if we're sending keep-alives to a discovery controller"
>  QUICK=1
>  
>  requires() {
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
>  }
>  
>  test() {
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 346f309..0506fa2 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -12,7 +12,7 @@ DESCRIPTION="test nvme and nvmet UUID NS descriptors"
>  QUICK=1
>  
>  requires() {
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
>  }
>  
>  test() {
> diff --git a/tests/nvme/015 b/tests/nvme/015
> index 29cf954..47e1b04 100755
> --- a/tests/nvme/015
> +++ b/tests/nvme/015
> @@ -10,7 +10,7 @@ DESCRIPTION="unit test for NVMe flush for file backed ns"
>  QUICK=1
>  
>  requires() {
> -	_have_program nvme && _have_modules loop nvme-loop && _have_configfs
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && _have_configfs
>  }
>  
>  test() {
> diff --git a/tests/nvme/018 b/tests/nvme/018
> index b09c29c..e29fa92 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -11,7 +11,7 @@ DESCRIPTION="unit test NVMe-oF out of range access on a file backend"
>  QUICK=1
>  
>  requires() {
> -	_have_program nvme && _have_modules nvme-loop && _have_modules loop && \
> +	_have_program nvme && _have_modules loop nvme-loop nvmet && \
>  		_have_configfs
>  }
>  
> -- 
> 2.17.2
> 
