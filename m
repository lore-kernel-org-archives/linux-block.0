Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC05CC77B6F
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 05:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDJFyZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 01:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDJFyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 01:54:19 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D94212
        for <linux-block@vger.kernel.org>; Sun,  9 Apr 2023 22:54:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A551E582006;
        Mon, 10 Apr 2023 01:54:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 Apr 2023 01:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681106052; x=1681106652; bh=OH
        GXfuWMqQ82qt9j7utCLAOAHMwJDqRxwbmDhUBuRxQ=; b=UqqZl8Txin6M4sAbcZ
        REEjsf2fZ50AWhskBNxOngEJ7LL/lvz2aIzeHZzao+FWmojo6X2vyH3o8qwLE1Ga
        1qffJ78ilRMzJwjuVqTcG9tUuPTdomC4EcmNJjfXwVGq4ppTHBZ4+u+HmfBYVHxw
        hooxiNgEnkDXKXtKX02w/H/PnVsTGhBq7WpDE6iu22vDNelihhe4fhNZh0YeAT8o
        SSHg5lXh41qyx0KzezTvys+mGHhSQM52hy5g+ItHScHlkTFs8Sk0WrA4IJ9/L0pa
        bbc5mEkEeYBmeiPcf/kgOpeutJi5IpKEIS13ATksnj948+Q3eAa439fNGap0rtCh
        E48A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm2; t=1681106052; x=1681106652; bh=OHG
        XfuWMqQ82qt9j7utCLAOAHMwJDqRxwbmDhUBuRxQ=; b=vq3eHIhHP6GIu3bNV2B
        MDiYGD3r3V+KGMYMG+abQJVn4TQiXA7UIVvT/hH5l9hH5tTO9UUITRQf4vuu5DUu
        Z/MSdWfqkPlA4Ic1XCQYgYuErcmx3YxZ+LDfmQICyQcI8Bozu1xnLBldjg1QQTFr
        +LAjtG0HFMKupmIwaq5GC6EyzDpwfsInHTnvbOM8liaIHdirFQV4Uo6CI5sZcQNS
        +xB9hIfIW+LPtcI+LisGHTOivKiatl33EdcFLu4QvCeqPtGF7PRNdZc6UtP31p+c
        sRUOdwO8b0nCefRcULjlJqnpp8VM1jFVzBvS63Bln/tdDp5bY1m+yrhraBgC64GG
        BDw==
X-ME-Sender: <xms:hKQzZCvJnNiggcoCX8063_4kNjrMqYNpcst296GDBHHTh6OZN_F_Xg>
    <xme:hKQzZHdlGB2GBKh9cHCxZNYQzS2SofbRPq5CWHYQVII_SsEMgDEQ0mE5RpH5iaDe3
    3V9lw0NEv8cgBSY3ZE>
X-ME-Received: <xmr:hKQzZNx1oAHNGrSM4v9DMGWb-OOne-qNL-FbcqAAjRfvQxeudZPXbzYp51RAlW1R0aaLwJOYCirbK-bCM8YTMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefuhhhi
    nhdkihgthhhirhhoucfmrgifrghsrghkihcuoehshhhinhhitghhihhrohesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelgeejiedvueeujeduveevgeegfedt
    hedukeehfeffgfehudffheeggfeikeetteenucffohhmrghinhepvddtudegqddtkedroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    hhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hKQzZNNC6Y56KphGUxCBWV4mhvJIUWM5lVr2eryfNIkurXeIthHH_A>
    <xmx:hKQzZC_KIjzaV2WZu3FQafnL1lmqizjM2P5UePZ5FocXILftDSz_dQ>
    <xmx:hKQzZFXssILsgbXBnESc9uC6HhpTtDwokw9PvwoH2Bd8vPpA2XdPuw>
    <xmx:hKQzZCzPSiyXEUUZwjhN5X5vEvZdWSXJOAKtOTM8Dl-Ltmgw8VK60dN-YA8>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 01:54:10 -0400 (EDT)
Date:   Mon, 10 Apr 2023 14:54:07 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 2/2] nvme/048: test queue count changes on
 reconnect
Message-ID: <exvrud3pulpsdm2mhxgkvhhgs4wr3hh3opwrvyxffv5fletkex@66jlhejm5ljn>
References: <20230406083050.19246-1-dwagner@suse.de>
 <20230406083050.19246-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406083050.19246-3-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 06, 2023 / 10:30, Daniel Wagner wrote:
> The target is allowed to change the number of I/O queues. Test if the
> host is able to reconnect in this scenario.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/048     | 125 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/048.out |   3 ++
>  2 files changed, 128 insertions(+)
>  create mode 100755 tests/nvme/048
>  create mode 100644 tests/nvme/048.out
> 
> diff --git a/tests/nvme/048 b/tests/nvme/048
> new file mode 100755
> index 000000000000..926f9f3de955
> --- /dev/null
> +++ b/tests/nvme/048
> @@ -0,0 +1,125 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2023 Daniel Wagner, SUSE Labs
> +#
> +# Test queue count changes on reconnect
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="Test queue count changes on reconnect"
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_require_nvme_trtype tcp rdma fc
> +	_require_min_cpus 2
> +}
> +
> +nvmf_wait_for_state() {
> +	local def_state_timeout=5
> +	local subsys_name="$1"
> +	local state="$2"
> +	local timeout="${3:-$def_state_timeout}"
> +	local nvmedev
> +	local state_file
> +	local start_time
> +	local end_time
> +
> +	nvmedev=$(_find_nvme_dev "${subsys_name}")
> +	state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
> +
> +	start_time=$(date +%s)
> +	while ! grep -q "${state}" "${state_file}"; do
> +		sleep 1
> +		end_time=$(date +%s)
> +                if (( end_time - start_time > timeout )); then

Nit: the line above has spaces instead of tabs.

> +			echo "expected state \"${state}\" not " \
> +				"reached within ${timeout} seconds"
> +			return 1
> +		fi
> +	done
> +
> +	return 0
> +}
> +
> +set_nvmet_attr_qid_max() {
> +	local nvmet_subsystem="$1"
> +	local qid_max="$2"
> +	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +
> +	echo "${qid_max}" > "${cfs_path}/attr_qid_max"
> +}
> +
> +set_qid_max() {
> +	local port="$1"
> +	local subsys_name="$2"
> +	local qid_max="$3"
> +
> +	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> +
> +	# Setting qid_max forces a disconnect and the reconntect attempt starts
> +	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
> +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +
> +	return 0
> +}
> +
> +test() {
> +	local subsys_name="blktests-subsystem-1"
> +	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
> +	local file_path="${TMPDIR}/img"
> +	local skipped=false
> +	local hostnqn
> +	local hostid
> +	local port
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	hostid="$(uuidgen)"
> +	if [ -z "$hostid" ] ; then
> +		echo "uuidgen failed"
> +		return 1
> +	fi
> +	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +
> +	truncate -s 512M "${file_path}"
> +
> +	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
> +		"b92842df-a394-44b1-84a4-92ae7d112861"
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
> +	_create_nvmet_host "${subsys_name}" "${hostnqn}"
> +
> +	if [[ -f "${cfs_path}/attr_qid_max" ]] ; then
> +		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
> +					--hostnqn "${hostnqn}" \
> +					--hostid "${hostid}" \
> +					--keep-alive-tmo 1 \
> +					--reconnect-delay 2
> +
> +		if ! nvmf_wait_for_state "${subsys_name}" "live" ; then
> +			echo FAIL
> +		else
> +			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
> +			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
> +		fi
> +
> +		_nvme_disconnect_subsys "${subsys_name}"
> +	else
> +		SKIP_REASONS+=("missing attr_qid_max feature")
> +		skipped=true
> +	fi
> +
> +	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> +	_remove_nvmet_subsystem "${subsys_name}"
> +	_remove_nvmet_port "${port}"
> +	_remove_nvmet_host "${hostnqn}"
> +
> +	rm "${file_path}"
> +
> +	if [[ "${skipped}" = true ]] ; then
> +		return 1
> +	fi
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/048.out b/tests/nvme/048.out
> new file mode 100644
> index 000000000000..7f986ef9637d
> --- /dev/null
> +++ b/tests/nvme/048.out
> @@ -0,0 +1,3 @@
> +Running nvme/048
> +NQN:blktests-subsystem-1 disconnected 1 controller(s)
> +Test complete
> -- 
> 2.40.0
> 
