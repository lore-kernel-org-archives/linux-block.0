Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677ECC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 01:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC84206B2
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 01:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="WjuWJpX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC84206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733228AbeKWLoY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Nov 2018 06:44:24 -0500
Received: from imap.thunk.org ([74.207.234.97]:44430 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeKWLoY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Nov 2018 06:44:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8pkuWe9777xprOhWNAccTDOslU5pF5XNTyYi06lxl6s=; b=WjuWJpX5/g69Ba0SH/rfIh7AY2
        /+peVI0JON6hqz58W5r9KlQDDamB7SwlozCAN8pmHiY4QdPTTGqMO09O1UPM6VDGZnsTSwlwT9oCd
        LWRUWplrDfCY0vwU53FQ8QpKpw+QtrhNYDkyjDq5SiOWBjmISHH5+jq2mlsiwPS0mYUw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gPzrS-0000Qp-Pv; Fri, 23 Nov 2018 01:02:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CD6FC7A43FA; Thu, 22 Nov 2018 20:02:21 -0500 (EST)
Date:   Thu, 22 Nov 2018 20:02:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests] Add use of logger so that syslog files show
 when each test starts
Message-ID: <20181123010221.GA6311@thunk.org>
References: <20181029161557.7652-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029161557.7652-1-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping?

					- Ted
					
On Mon, Oct 29, 2018 at 12:15:57PM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  check | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/check b/check
> index f6c3537..ebd87c0 100755
> --- a/check
> +++ b/check
> @@ -319,6 +319,7 @@ _call_test() {
>  		local dmesg_marker=""
>  		CHECK_DMESG=0
>  	fi
> +	$LOGGER_PROG "run blktests $TEST_NAME"
>  
>  	trap _cleanup EXIT
>  	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
> @@ -578,6 +579,8 @@ fi
>  eval set -- "$TEMP"
>  unset TEMP
>  
> +LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
> +
>  if [[ -r config ]]; then
>  	# shellcheck disable=SC1091
>  	. config
> -- 
> 2.18.0.rc0
> 
