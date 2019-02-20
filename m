Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB38C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9664C21841
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="mwDfVbh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfBTSKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:10:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34094 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfBTSKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:10:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so5475196plr.1
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r0tVEWdXrgzyxumZUftJcmfCZXkOlJcVcEgxnhTfl6Q=;
        b=mwDfVbh4oqQO/NpkWdK1t33lF3fZVO5A+C5P9wAFwds/DocY3hNiOBbENid2sJBbA/
         tEpFmCzqlPwBIgcCnNWINn67yYcUeUAUq3/rI3r2JgHEE/w4Uz6dAcaoKsaZy9VECUPT
         /V9Zj7b1QO5zqyOGwqmnMyd542Gdf5p5Q+FWEiunBqAvsDgd9Pa9qWvf3hUqOhF8H80G
         NJi5cMN6C6/U2q/CEcfKP3dUH/I9qFEp6IWtS7LH1XlKEbgCVKNi5z0wqtgRo9ybkioT
         x2fsXIHgpCSS6OYwqdiUDgSBwXiTtmN6q3tGA5qGu5yax66LcxEJfkpg6M/NHNfW2bBI
         sIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0tVEWdXrgzyxumZUftJcmfCZXkOlJcVcEgxnhTfl6Q=;
        b=mI4OlbImH4xkMXf8B2UwGOudR1AdkB4hu1iVf7iRzg3yKgdozg9HKmykTUuVey7wN8
         16w/oCyCUVrOywIGjXnkQdroCKfU9GxlBQVutASoQtrTutx9KyDSVCV4r4BwLACvfZ1C
         qFwrwZrnuiJKYZuQGfGr+1TO/jUvuvM08Az0affb3kilddnCjqpEFbNTm++fPbgkyD2E
         P99py0k4syFw8SDbvs97xzkCmloLzw0v+24WFMd3uW1xvKlY28/tyRI3k4dJC7flChyE
         dCfclsvNvUbJeCA1KIIeET+UM6fxUX8A1zngFmE9zd3rRiVY0WHs73sQx7pYF2UMDs0+
         hh+A==
X-Gm-Message-State: AHQUAubOnj16c/3v4r/mxi5S31wK6Ak3CvUC1VCoecMXY4U6hn11AfY6
        eJh9/xUe73HUac6TCMKnzBA3Ew==
X-Google-Smtp-Source: AHgI3IaTK3chY7p0f6at2okqObLLXCpVDLO4dDCNS9Y4EBV/SsJ/toVeSUdN0iOQhIo4WIp+QSU7sA==
X-Received: by 2002:a17:902:6681:: with SMTP id e1mr37436529plk.98.1550686244813;
        Wed, 20 Feb 2019 10:10:44 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id t12sm52153031pgq.68.2019.02.20.10.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:10:44 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:10:42 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH 1/8] nvme/021: use consistent coding style
Message-ID: <20190220181042.GB8325@vader>
References: <1550618905-4112-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550618905-4112-2-git-send-email-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550618905-4112-2-git-send-email-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 03:28:18PM -0800, Chaitanya Kulkarni wrote:
> ---
>  tests/nvme/021     | 15 ++++++---------
>  tests/nvme/021.out |  1 -
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/nvme/021 b/tests/nvme/021
> index 8e9512a..f204a2f 100755
> --- a/tests/nvme/021
> +++ b/tests/nvme/021
> @@ -38,11 +38,13 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
>  
> -	nvme list > /dev/null 2>&1
> -
> -	rc=$?
> +	if ! nvme list | grep -q "${nvmedev}n1" > /dev/null 2>&1; then
> +		echo "Test Failed"
> +	else
> +		echo "Test complete"
> +	fi
>  
> -	nvme disconnect -n "${subsys_name}"
> +	nvme disconnect -n "${subsys_name}" > /dev/null 2>&1
>  
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
>  	_remove_nvmet_subsystem "${subsys_name}"
> @@ -53,9 +55,4 @@ test() {
>  	modprobe -r nvme-loop
>  	modprobe -r nvmet
>  
> -	if [ $rc -ne 0 ]; then
> -		echo "Test Failed"
> -	else
> -		echo "Test complete"
> -	fi
>  }
> diff --git a/tests/nvme/021.out b/tests/nvme/021.out
> index 5fb0601..b6b1a7c 100644
> --- a/tests/nvme/021.out
> +++ b/tests/nvme/021.out
> @@ -1,5 +1,4 @@
>  Running nvme/021
>  91fdba0d-f87b-4c25-b80f-db7be1418b9e
>  uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
> -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>  Test complete
> -- 
> 1.8.3.1
> 

For all of these, I think it'd be useful to have a more descriptive
error, like so:

diff --git a/tests/nvme/021 b/tests/nvme/021
index 8e9512a..0b215c4 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -38,9 +38,9 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	nvme list > /dev/null 2>&1
-
-	rc=$?
+	if ! nvme list | grep -q "${nvmedev}n1"; then
+		echo "NVMeOF device not listed"
+	fi
 
 	nvme disconnect -n "${subsys_name}"
 
@@ -53,9 +53,5 @@ test() {
 	modprobe -r nvme-loop
 	modprobe -r nvmet
 
-	if [ $rc -ne 0 ]; then
-		echo "Test Failed"
-	else
-		echo "Test complete"
-	fi
+	echo "Test complete"
 }
