Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3513A245
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482355; cv=none; b=peZ0d01DwCCAzWhDMNuoFvCu4gascMDxDNb3RG0LoVcIKsLLrYPG/AOsN1c/ZOrawVXzMtWRh1BGvHx7rLbV2k6nlgppXtE+4i1tsx5am9Jls1WvHZ65EjgwzLYrRuOZMzt+t9LjY0sDXzq6OAfVZAmMs7RmnOx+duhIOEgj8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482355; c=relaxed/simple;
	bh=iVI4ZkNifioWtzq9s0rxPM5dCY9Xs2i4PtaTrWU9u5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0brMRy6rvigNwRlVXfgtpwtjBUI1r3XaJxmnP88YCU+Whf90AiViGN9TasQ9BaNCcXUYQVKI8BP2nRmHxox8rltRk/O0CDZVbwP020HYVFaK0wYwdLwSeS/Yx6a+Q96rSVfsXrx3sSHT2+pLUCJmB3zpIEMKaCqibbrliKZR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC16E21B00;
	Thu, 27 Jun 2024 09:59:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81C7D137DF;
	Thu, 27 Jun 2024 09:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MPC6Hu83fWaaJAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Jun 2024 09:59:11 +0000
Message-ID: <c3475515-e776-41cd-8c60-e0f5fccea052@suse.de>
Date: Thu, 27 Jun 2024 11:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 1/3] nvme/rc: introduce remote target support
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627091016.12752-1-dwagner@suse.de>
 <20240627091016.12752-2-dwagner@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240627091016.12752-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: AC16E21B00
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 6/27/24 11:10, Daniel Wagner wrote:
> Most of the NVMEeoF tests are exercising the host code of the nvme
> subsystem. There is no real reason not to run these against a real
> target. We just have to skip the soft target setup and make it possible
> to setup a remote target.
> 
> Because all tests use now the common setup/cleanup helpers we just need
> to intercept this call and forward it to an external component.
> 
> As we already have various nvme variables to setup the target which we
> should allow to overwrite. Also introduce a NVME_TARGET_CONTROL variable
> which points to a script which gets executed whenever a targets needs to
> be created/destroyed.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   Documentation/running-tests.md | 33 ++++++++++++++++++++
>   check                          |  4 +++
>   tests/nvme/rc                  | 57 ++++++++++++++++++++++++++++++++--
>   3 files changed, 92 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index 968702e76bb5..fe4f729bd037 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -120,6 +120,9 @@ The NVMe tests can be additionally parameterized via environment variables.
>   - NVME_NUM_ITER: 1000 (default)
>     The number of iterations a test should do. This parameter had an old name
>     'nvme_num_iter'. The old name is still usable, but not recommended.
> +- NVME_TARGET_CONTROL: When defined, the generic target setup/cleanup code will
> +  be skipped and this script gets called. This makes it possible to run
> +  the fabric nvme tests against a real target.
>   
>   ### Running nvme-rdma and SRP tests
>   
> @@ -167,3 +170,33 @@ if ! findmnt -t configfs /sys/kernel/config > /dev/null; then
>   	mount -t configfs configfs /sys/kernel/config
>   fi
>   ```
> +### NVME_TARGET_CONTROL
> +
> +When NVME_TARGET_CONTROL is set, blktests will call the script which the
> +environment variable points to, to fetch the configuration values to be used for
> +the runs, e.g subsysnqn or hostnqn. This allows the blktest to be run against
> +external configured/setup targets.
> +
> +The blktests expects that the script interface implements following
> +commands:
> +
> +config:
> +  --show-blkdev-type
> +  --show-trtype
> +  --show-hostnqn
> +  --show-hostid
> +  --show-host-traddr
> +  --show-traddr
> +  --show-trsvid
> +  --show-subsys-uuid
> +  --show-subsysnqn
> +
> +setup:
> +  --subsysnqn SUBSYSNQN
> +  --subsys-uuid SUBSYS_UUID
> +  --hostnqn HOSTNQN
> +  --ctrlkey CTRLKEY
> +  --hostkey HOSTKEY
> +
> +cleanup:
> +  --subsysnqn SUBSYSNQN
> diff --git a/check b/check
> index 3ed4510f3f40..d0475629773d 100755
> --- a/check
> +++ b/check
> @@ -603,6 +603,10 @@ _run_group() {
>   	# shellcheck disable=SC1090
>   	. "tests/${group}/rc"
>   
> +	if declare -fF group_setup >/dev/null; then
> +		group_setup
> +	fi
> +
>   	if declare -fF group_requires >/dev/null; then
>   		group_requires
>   		if [[ -v SKIP_REASONS ]]; then
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index c1ddf412033b..4465dea0370b 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -23,6 +23,7 @@ _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
>   _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
>   nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
>   NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
> +nvme_target_control="${NVME_TARGET_CONTROL:-}"
>   
>   _NVMET_TRTYPES_is_valid() {
>   	local type
> @@ -135,6 +136,13 @@ _nvme_requires() {
>   	return 0
>   }
>   
> +group_setup() {
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		NVMET_TRTYPES="$(${nvme_target_control} config --show-trtype)"
> +		NVMET_BLKDEV_TYPES="$(${nvme_target_control} config --show-blkdev-type)"
> +	fi
> +}
> +
>   group_requires() {
>   	_have_root
>   	_NVMET_TRTYPES_is_valid
> @@ -359,6 +367,10 @@ _cleanup_nvmet() {
>   		fi
>   	done
>   
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		return
> +	fi
> +
>   	for port in "${NVMET_CFS}"/ports/*; do
>   		name=$(basename "${port}")
>   		echo "WARNING: Test did not clean up port: ${name}"
> @@ -403,11 +415,26 @@ _cleanup_nvmet() {
>   
>   _setup_nvmet() {
>   	_register_test_cleanup _cleanup_nvmet
> +
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		def_hostnqn="$(${nvme_target_control} config --show-hostnqn)"
> +		def_hostid="$(${nvme_target_control} config --show-hostid)"
> +		def_host_traddr="$(${nvme_target_control} config --show-host-traddr)"
> +		def_traddr="$(${nvme_target_control} config --show-traddr)"
> +		def_trsvcid="$(${nvme_target_control} config --show-trsvid)"
> +		def_subsys_uuid="$(${nvme_target_control} config --show-subsys-uuid)"
> +		def_subsysnqn="$(${nvme_target_control} config --show-subsysnqn)"
> +		return
> +	fi
> +
>   	modprobe -q nvmet
> +
>   	if [[ "${nvme_trtype}" != "loop" ]]; then
>   		modprobe -q nvmet-"${nvme_trtype}"
>   	fi
> +
>   	modprobe -q nvme-"${nvme_trtype}"
> +
>   	if [[ "${nvme_trtype}" == "rdma" ]]; then
>   		start_soft_rdma
>   		for i in $(rdma_network_interfaces)
> @@ -425,6 +452,7 @@ _setup_nvmet() {
>   			fi
>   		done
>   	fi
> +
>   	if [[ "${nvme_trtype}" = "fc" ]]; then
>   		modprobe -q nvme-fcloop
>   		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> @@ -873,11 +901,13 @@ _find_nvme_passthru_loop_dev() {
>   
>   _nvmet_target_setup() {
>   	local blkdev_type="${nvmet_blkdev_type}"
> +	local subsys_uuid="${def_subsys_uuid}"
> +	local subsysnqn="${def_subsysnqn}"
>   	local blkdev
> +	local ARGS=()
>   	local ctrlkey=""
>   	local hostkey=""
> -	local subsysnqn="${def_subsysnqn}"
> -	local subsys_uuid="${def_subsys_uuid}"
> +	local blkdev
>   	local port
>   
>   	while [[ $# -gt 0 ]]; do
> @@ -909,6 +939,22 @@ _nvmet_target_setup() {
>   		esac
>   	done
>   
> +	if [[ -n "${hostkey}" ]]; then
> +		ARGS+=(--hostkey "${hostkey}")
> +	fi
> +	if [[ -n "${ctrlkey}" ]]; then
> +		ARGS+=(--ctrkey "${ctrlkey}")
> +	fi
> +
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		eval "${nvme_target_control}" setup \
> +			--subsysnqn "${subsysnqn}" \
> +			--subsys-uuid "${subsys_uuid}" \
> +			--hostnqn "${def_hostnqn}" \
> +			"${ARGS[@]}" &> /dev/null
> +		return
> +	fi
> +
>   	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>   	if [[ "${blkdev_type}" == "device" ]]; then
>   		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
> @@ -948,6 +994,13 @@ _nvmet_target_cleanup() {
>   		esac
>   	done
>   
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		eval "${nvme_target_control}" cleanup \
> +			--subsysnqn "${subsysnqn}" \
> +			> /dev/null
> +		return
> +	fi
> +
>   	_get_nvmet_ports "${subsysnqn}" ports
>   
>   	for port in "${ports[@]}"; do

Hmm. This wasn't quite what I had in mind; I think it'd be simpler
if we could just check if the requested controller is visible to the
host already (ie checking sysfs here), and then skip all the setup
steps at they are obviously not required anymore.
That would save quite a lot of issues, and we wouldn't need to specify
a target setup script (or whatever).

Quite a bit of churn, I agree, as that would mean we have to roll

	_setup_nvmet

	_nvmet_target_setup

	_nvme_connect_subsys

all into one function. But it might be easier in the long run.
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

