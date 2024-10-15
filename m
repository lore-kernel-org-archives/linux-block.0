Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976E173357
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971939; cv=none; b=OLfsJ70m1s/NqF5KasqkWvqJS5rt8vOLboX3SoXEhJv8zPSjMv5jNNYYKa6zCEhOQu7zSQp9d1C33mjWYoYxCSTTeKZzOwSn8FVwEwda9qyjJS6pm9fkM6lHYitwDb8ZC23nuAbmwaAV/RIIy3+hHHPKx5NFFh/NSDtp9eF4O/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971939; c=relaxed/simple;
	bh=GthhN/+Sa9ty+mT7s80Qsu+GDYg4A3s06C4sLNYrJqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcwZHrVGKUBVUOPm7zEDo6MJB/IXaCDwPCOiNic0Dlaz6GS4Wz4yarZLcLk22S2l1Gv7r8xrbnpVqJCbcq7D8lsQCi8jqI7YsrkOrgcbpUVLhjvqBWjH59mgmksEWNpuZfF8I8EdiHB0Q3QLmUnZ/iB5J0h7N2T1RvUMSpo5g14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gr0eNZre; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G2/WHTVs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gr0eNZre; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G2/WHTVs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gr0eNZre";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G2/WHTVs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gr0eNZre";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G2/WHTVs"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9986621BD9;
	Tue, 15 Oct 2024 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728971929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=gr0eNZrern9+G96Oji6U0l05WMtFEi7aqbcWRUHb54cc68PupLWbQbK1XSKa7vassx5O0n
	5pyGoNcrHnEGALfUxSo6FgbIYB03A6oXjRueJicQCm/DMfD3OBk9nc0WMKuHIwBzQYm+Nh
	SbF5d6Loqf6aUayLGkA+o/fsRmMthug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728971929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=G2/WHTVsITndJ4q1mwgYdff3YfQWnPszmam/b9iE+RvGLipJf9WYrPk4moKcoEt3Sa6DyE
	S0AnI8TM5PDGcFAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gr0eNZre;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="G2/WHTVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728971929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=gr0eNZrern9+G96Oji6U0l05WMtFEi7aqbcWRUHb54cc68PupLWbQbK1XSKa7vassx5O0n
	5pyGoNcrHnEGALfUxSo6FgbIYB03A6oXjRueJicQCm/DMfD3OBk9nc0WMKuHIwBzQYm+Nh
	SbF5d6Loqf6aUayLGkA+o/fsRmMthug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728971929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=alOGch4zkJfB39/mcydvV5EYgE69+94ctOo1z8AD8Gk=;
	b=G2/WHTVsITndJ4q1mwgYdff3YfQWnPszmam/b9iE+RvGLipJf9WYrPk4moKcoEt3Sa6DyE
	S0AnI8TM5PDGcFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80CA213A53;
	Tue, 15 Oct 2024 05:58:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FnkNHZkEDmfgYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 15 Oct 2024 05:58:49 +0000
Date: Tue, 15 Oct 2024 07:58:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v5 2/2] nvme: test the nvme reservation feature
Message-ID: <6a983a2b-c3ab-4948-8bfd-4d3e2cfde88c@flourine.local>
References: <20241015024350.16271-1-kanie@linux.alibaba.com>
 <20241015024350.16271-3-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015024350.16271-3-kanie@linux.alibaba.com>
X-Rspamd-Queue-Id: 9986621BD9
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, Oct 15, 2024 at 10:43:50AM GMT, Guixin Liu wrote:
> Test the NVMe reservation feature, including register, acquire,
> release and report.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Looks good to me. Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

> ---
>  tests/nvme/054     | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/054.out |  68 ++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 tests/nvme/054
>  create mode 100644 tests/nvme/054.out
> 
> diff --git a/tests/nvme/054 b/tests/nvme/054
> new file mode 100644
> index 0000000..71c625c
> --- /dev/null
> +++ b/tests/nvme/054
> @@ -0,0 +1,101 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Guixin Liu
> +# Copyright (C) 2024 Alibaba Group.
> +#
> +# Test the NVMe reservation feature
> +#
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test the NVMe reservation feature"
> +QUICK=1
> +nvme_trtype="loop"
> +
> +requires() {
> +	_nvme_requires
> +}
> +
> +resv_report() {
> +	local test_dev=$1
> +	local report_arg=$2
> +
> +	nvme resv-report "${test_dev}" "${report_arg}" | grep -v "hostid" | \
> +		grep -E "gen|rtype|regctl|regctlext|cntlid|rcsts|rkey"
> +}
> +
> +test_resv() {
> +	local ns=$1
> +	local report_arg="--cdw11=1"
> +	test_dev="/dev/${ns}"
> +
> +	if nvme resv-report --help 2>&1 | grep -- '--eds' > /dev/null; then
> +		report_arg="--eds"
> +	fi
> +
> +	echo "Register"
> +	resv_report "${test_dev}" "${report_arg}"
> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Replace"
> +	nvme resv-register "${test_dev}" --crkey=4 --nrkey=5 --rrega=2
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Unregister"
> +	nvme resv-register "${test_dev}" --crkey=5 --rrega=1
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Acquire"
> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Preempt"
> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Release"
> +	nvme resv-release "${test_dev}" --crkey=4 --rtype=2 --rrela=0
> +	resv_report "${test_dev}" "${report_arg}"
> +
> +	echo "Clear"
> +	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
> +	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
> +	resv_report "${test_dev}" "${report_arg}"
> +	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +
> +	local ns
> +	local skipped=false
> +	local subsys_path=""
> +	local ns_path=""
> +
> +	_nvmet_target_setup --blkdev file --resv_enable
> +	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
> +	_nvme_connect_subsys
> +
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +	ns_id=$(echo "${ns}" | grep -oE '[0-9]+' | sed -n '2p')
> +	ns_path="${subsys_path}/namespaces/${ns_id}"
> +
> +	if [[ -f "${ns_path}/resv_enable" ]] ; then
> +		test_resv "${ns}"
> +	else
> +		SKIP_REASONS+=("missing reservation feature")
> +		skipped=true
> +	fi
> +
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +
> +	if [[ "${skipped}" = true ]] ; then
> +		return 1
> +	fi
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/054.out b/tests/nvme/054.out
> new file mode 100644
> index 0000000..5adb30d
> --- /dev/null
> +++ b/tests/nvme/054.out
> @@ -0,0 +1,68 @@
> +Running nvme/054
> +Register
> +gen       : 0
> +rtype     : 0
> +regctl    : 0
> +NVME Reservation  success
> +gen       : 1
> +rtype     : 0
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 0
> +  rkey       : 4
> +Replace
> +NVME Reservation  success
> +gen       : 2
> +rtype     : 0
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 0
> +  rkey       : 5
> +Unregister
> +NVME Reservation  success
> +gen       : 3
> +rtype     : 0
> +regctl    : 0
> +Acquire
> +NVME Reservation  success
> +NVME Reservation Acquire success
> +gen       : 4
> +rtype     : 1
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 1
> +  rkey       : 4
> +Preempt
> +NVME Reservation Acquire success
> +gen       : 5
> +rtype     : 2
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 1
> +  rkey       : 4
> +Release
> +NVME Reservation Release success
> +gen       : 5
> +rtype     : 0
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 0
> +  rkey       : 4
> +Clear
> +NVME Reservation  success
> +NVME Reservation Acquire success
> +gen       : 6
> +rtype     : 1
> +regctl    : 1
> +regctlext[0] :
> +  cntlid     : ffff
> +  rcsts      : 1
> +  rkey       : 4
> +NVME Reservation Release success
> +disconnected 1 controller(s)
> +Test complete
> -- 
> 2.43.0
> 
