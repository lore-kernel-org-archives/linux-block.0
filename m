Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8798CD98F3
	for <linux-block@archiver.kernel.org>; Wed, 11 Oct 2023 06:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjJKGxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Oct 2023 02:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJKGxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 02:53:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEEFF4
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2023 23:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E58D2185D;
        Wed, 11 Oct 2023 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697007178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO7BBqCZuJ0eghg5dsje8lMExWOqMRk95hSKX0GobG8=;
        b=Tt96JQY6IPnK6559AwgvA0b37EX8o+qStLgtsWUpqRDWl0eU2cIarQhG1JfxIshJzU2raQ
        11rEfuE5jzNm6Cw1bYcjv9V7hrAwJw0DK99nUv/l6PQUUpplOHW5VQ7Hxagd3Q6zzTFnLZ
        Wa0Eq/AOmNi9ixHHyf8o2IFfPryL8O4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697007178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO7BBqCZuJ0eghg5dsje8lMExWOqMRk95hSKX0GobG8=;
        b=d2jW4Di7Kphan6yotDJk/F+MmZkOK+mnrLWdavwuW96tk0Q/L7XwO7gZk9BOu3db0mHYDr
        oS+kNzAeY1QePBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90AA8134F5;
        Wed, 11 Oct 2023 06:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sCFII0pGJmUnbgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 11 Oct 2023 06:52:58 +0000
Date:   Wed, 11 Oct 2023 08:54:09 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] check: define TMPDIR before running the test
Message-ID: <xhh4o6xisfaybzozsia5owr5mzs4eyqn2yvrxogw5u55ht2lgd@hp3k4jb5mwsd>
References: <20231011034832.1650797-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011034832.1650797-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Wed, Oct 11, 2023 at 11:48:32AM +0800, Yi Zhang wrote:
> @@ -478,6 +475,10 @@ _run_test() {
>  	# runs to suppress job status output.
>  	set +m
>  
> +	if ! TMPDIR="$(mktemp --tmpdir -p "$OUTPUT" -d "tmpdir.${TEST_NAME//\//.}.XXX")"; then
> +		return
> +	fi
> +
>  	# shellcheck disable=SC1090
>  	. "tests/${TEST_NAME}"

Are you sure about the placement here? I went through the call chain
and I figured that the TMPDIR should be set in _run_group before
we call the 'rc' files.

Currently it is:

_check
  _run_group
    tests/${group}/rc
    _run_test
      _call_test
        TMPDIR=...
        $test_func

Thanks,
Daniel
