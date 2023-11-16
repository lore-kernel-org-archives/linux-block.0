Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AEC/jdcX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z3xOZh3D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0315120
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 23:32:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5032222924;
	Thu, 16 Nov 2023 07:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700119958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTezg+sc0Tnb91YVBGMGJIvF6L7L5vCGPC8EpjzZBIw=;
	b=AEC/jdcXE+AK0x/uUiEq2T+IIltgj9fLWZEYAbhxwCd59cRxFfoNjAUmlLBKixt+1P+Fvy
	OCvvylPxKck8jGLEMskd04x1NQwXyxZsAUn7QMGqzWHuGMnHixI3y6G6YYjja2EKhAt4go
	11PoXGjPzfLrJauctJjRnBESK3LN+Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700119958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTezg+sc0Tnb91YVBGMGJIvF6L7L5vCGPC8EpjzZBIw=;
	b=z3xOZh3DHrfkWVVIozpit/zli0yJaSS3+WWIoITAYuubwDlmoTAQ/wAj3HHah1hj3F7/2V
	flip5E/KA2JL7rCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A8C51377E;
	Thu, 16 Nov 2023 07:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id DHA3BJbFVWUfRgAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 16 Nov 2023 07:32:38 +0000
Message-ID: <ab72deff-d0e8-42bd-ba93-37f04350ce50@suse.de>
Date: Thu, 16 Nov 2023 08:32:37 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Yi Zhang <yi.zhang@redhat.com>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
 <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
 <ebf8d5ed-1fe6-4962-a363-5b11cd01bd70@suse.de>
 <bkd22lp42ewpp6u7lws2alcbfzjzt6yp7m3ou2ugdukiyuwqt5@pjnxq5uqnjlc>
 <fd9a0f77-116d-4eb6-ab3b-8af08dda878e@suse.de>
 <6fwo7puujh4dgoppilxwtg6t2d3sf7l7jp7ifyjprgj5litjtt@b6qoyootcnnr>
 <3c5daxlrkpyf6l3asotx7gqczqo32ffzjjvfoobchvwq56c4hv@r4llw3v2msvl>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <3c5daxlrkpyf6l3asotx7gqczqo32ffzjjvfoobchvwq56c4hv@r4llw3v2msvl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.29
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.993];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On 11/16/23 04:03, Shinichiro Kawasaki wrote:
> On Nov 16, 2023 / 02:09, Shinichiro Kawasaki wrote:
>> On Nov 15, 2023 / 15:32, Hannes Reinecke wrote:
>>> On 11/15/23 15:18, Daniel Wagner wrote:
> [...]
>>>> diff --git a/tests/nvme/045 b/tests/nvme/045
>>>> index 1eb1032a3b93..954f96bedd5a 100755
>>>> --- a/tests/nvme/045
>>>> +++ b/tests/nvme/045
>>>> @@ -17,6 +17,7 @@ requires() {
>>>>           _have_kernel_option NVME_TARGET_AUTH
>>>>           _require_nvme_trtype_is_fabrics
>>>>           _require_nvme_cli_auth
>>>> +       _require_kernel_nvme_feature dhchap_ctrl_secret
>>
>> The idea looked good and I checked /dev/nvme-fabrics content on kernel v6.7-
>> rc1. But unfortunately, I found that /dev/nvme-fabrics content is same
>> regardless of the kernel config NVME_HOST_AUTH. I checked opt_tokens in
>> drivers/nvme/host/fabrics.c, and saw that "dhchap_ctrl_secret=%s" is not
>> surrounded with #ifdef CONFIG_NVME_HOST_AUTH. Should we add the #ifdef?
>>
>> I tried to find out other differences that NVME_HOST_AUTH makes and visible
>> from userland. I found ctrl_dhchap_secret sysfs attribute of nvme devices is
>> in #ifdef CONFIG_HOST_AUTH. But to find the attribute, it looks "nvme connect"
>> needs to happen before-hand. So the attribute does not look usable. Hmm.
> 
> I rethought about the ctrl_dhchap_secret sysfs attribute, and came up with an
> idea to set up nvme target without host key and do "nvme connect". (With host
> key, nvme connect fails). Then check if the sysfs attributes exists or not.
> 
> I quickly created a patch below, and it looks working. The check creates a nvme
> target and affects the test system, then I think it should be done in test()
> rather than requires(). If there is no better idea, we can take this solution.
> 
> diff --git a/tests/nvme/041 b/tests/nvme/041
> index d23f10a..28322e4 100755
> --- a/tests/nvme/041
> +++ b/tests/nvme/041
> @@ -27,6 +27,10 @@ test() {
>   	local hostkey
>   	local ctrldev
>   
> +	if ! _nvme_host_supports_dhchap_ctrl_secret; then
> +		return 1
> +	fi
> +
>   	hostkey="$(nvme gen-dhchap-key -n ${def_subsysnqn} 2> /dev/null)"
>   	if [ -z "$hostkey" ] ; then
>   		echo "nvme gen-dhchap-key failed"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1cff522..9e77d7a 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -1010,3 +1010,21 @@ _nvme_reset_ctrl() {
>   _nvme_delete_ctrl() {
>   	echo 1 > /sys/class/nvme/"$1"/delete_controller
>   }
> +
> +# Set up nvme target without hostkey and see if dhchap_ctrl_secret exists.
> +_nvme_host_supports_dhchap_ctrl_secret() {
> +	local ctrldev
> +	local ret=0
> +
> +	_nvmet_target_setup --hostkey ""
> +	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> +	cdev=$(_find_nvme_dev "${def_subsysnqn}")
> +	if [[ -z $cdev || ! -e "/sys/class/nvme/${cdev}/dhchap_ctrl_secret" ]]; then
> +		ret=1
> +		SKIP_REASONS+=("dhchap_ctrl_secret is not enabled (check CONFIG_NVME_HOST_AUTH)")
> +	fi
> +	_nvme_disconnect_subsys "${def_subsysnqn}" > /dev/null 2>&1
> +	_nvmet_target_cleanup
> +
> +	return $ret
> +}

Errm. Not quite what I had in mind.

To step back a bit: why again do you want to run these tests on older 
kernels? If authentication is not present it's _quite_ pointless running 
them...
So what's the rationale?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

