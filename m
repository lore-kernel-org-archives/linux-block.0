Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A20250EA
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rg56aY+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GS7TrBHy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B8E6
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 06:16:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 19D861F8BA;
	Wed, 15 Nov 2023 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700057796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVPctJnpR2bAUgb9avhYYP26mTLjlT3Lg0c61Mw6I+E=;
	b=Rg56aY+PB3T+MZZAdMNlc5NvdJgePPznM9Le2a5TX9AGYHmRZnxuC8m6okkhQ9bqtoY0yU
	t7kbAa/PU+qYATfdp91OUnI949MWgg436ruFYefq0W7us1urxH5oeJUnt7ZkiaC+00z6n3
	TU6Nl8mVKijDcjBilg5qiUoW1TxTVKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700057796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tVPctJnpR2bAUgb9avhYYP26mTLjlT3Lg0c61Mw6I+E=;
	b=GS7TrBHyVtlQbxh/gCqemaVUpoIpziIJ2fqUYndLpHwg4LwrU8JOtAlGQsQuGpdmd7o4VH
	MSm1yv3IwON1tFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E4A113592;
	Wed, 15 Nov 2023 14:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gyR4A8TSVGX6WAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 15 Nov 2023 14:16:36 +0000
Date: Wed, 15 Nov 2023 15:18:32 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Message-ID: <bkd22lp42ewpp6u7lws2alcbfzjzt6yp7m3ou2ugdukiyuwqt5@pjnxq5uqnjlc>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
 <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
 <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Wed, Nov 15, 2023 at 09:20:28AM +0100, Hannes Reinecke wrote:
> > I agree that kernel version dependency is not the best. As another solution,
> > I considered introducing a helper function _kernel_option_exists() which
> > checks if one of strings "# CONFIG_NVME_HOST_AUTH is not set" or
> > "# CONFIG_NVME_HOST_AUTH=[ym]" exists in kernel config files. With this, we
> > can do as follows:
> > 
> >    _kernel_option_exists NVME_HOST_AUTH && _have_kernel_option NVME_HOST_AUTH
> > 
> > This assumes that one of the strings always exists in kernel configs. I was not
> > sure about the assumption, then chose the way to check kernel version. (Any
> > advice on this assumption will be appreciated...)
> 
> None of this is really a good solution. Probably we should strive to make
> nvme-cli handling this situation correctly; after all, it would know if the
> fabrics option is supported or not.

nvme-cli is detecting if a feature is present by reading
/dev/nvme-fabrics. I think we should do something similar in blktest
but not by calling nvme-cli in the _require() block. Though we don't
have to rely on nvme-cli. We can do something like this:


diff --git a/tests/nvme/045 b/tests/nvme/045
index 1eb1032a3b93..954f96bedd5a 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -17,6 +17,7 @@ requires() {
        _have_kernel_option NVME_TARGET_AUTH
        _require_nvme_trtype_is_fabrics
        _require_nvme_cli_auth
+       _require_kernel_nvme_feature dhchap_ctrl_secret
        _have_driver dh_generic
 }

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1cff522d8543..67b812cf0c66 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -155,6 +155,17 @@ _require_nvme_cli_auth() {
        return 0
 }

+_require_kernel_nvme_feature() {
+       local feature="$1"
+
+       if ! [ -f /dev/nvme-fabrics ]; then
+               return 1;
+       fi
+
+       grep "${feature}" /dev/nvme-fabrics
+       return $?
+}
+
 _test_dev_nvme_ctrl() {
        echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
