Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9828F5
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359699; cv=none; b=elr4XrLmCqTR3CUocoAjKrlxTQwc6/ruJ2TWpKw58z2n+iWl0O4A11HjT5cbq4Puo3MBoqX3WHggIYILinbjxZoAeiEjgRxxGnfSVvhX8QG2fDyWI0kNk2rzcqt0J75JVaJjCgkzqTUP7D0yJuW27NOG3+fkRoXfzwZlqTSQpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359699; c=relaxed/simple;
	bh=DOuqV29G/Evs0ImefCI5W0jmv4/CU1c/mkEfg870Pws=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mje6v5nQccYZwpy3nFB64VABosRgT9WSLweHidMbzZVk+spfZ+tLQRlg5W2TrpB3sm9D9iJxYsa6sC+WIaeInfD9+oFj9/ABVHxfjkVgxJXm+DkCjv/URei8L1cSokYARCjV4GXnJt+sAj0H9e+gGK1iXiXlNuUKwkv1pWONd1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQFVl4Lgfz4f3lWJ
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:27:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E391D1A09EC
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:28:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXezlL3ZlmFHQnAg--.59795S3;
	Fri, 19 Jul 2024 11:28:12 +0800 (CST)
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
To: Ofir Gal <ofir.gal@volumez.com>, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 dwagner@suse.de, chaitanyak@nvidia.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <4e7a4961-233e-04f8-776d-0886e1640db8@huaweicloud.com>
Date: Fri, 19 Jul 2024 11:28:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240716115026.1783969-3-ofir.gal@volumez.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXezlL3ZlmFHQnAg--.59795S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyDKrWfur17Jr45GF1fXrb_yoWruw4rpa
	yqgF9Yyr1xGFy2gF13W3WY9FyrGws7Z34YkryxWw1DAr90qryS9a4xKrsrZ3y3Jr1kZF10
	v34vqFyrur1DGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/07/16 19:50, Ofir Gal Ð´µÀ:
> A bug in md-bitmap has been discovered by setting up a md raid on top of
> nvme-tcp devices that has optimal io size larger than the allocated
> bitmap.
> 
> The following test reproduce the bug by setting up a md-raid on top of
> nvme-tcp device over ram device that sets the optimal io size by using
> dm-stripe.
> 
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>   common/brd       | 28 ++++++++++++++++
>   tests/md/001     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/md/001.out |  3 ++
>   tests/md/rc      | 12 +++++++
>   4 files changed, 128 insertions(+)
>   create mode 100644 common/brd
>   create mode 100755 tests/md/001
>   create mode 100644 tests/md/001.out
>   create mode 100644 tests/md/rc
> 
> diff --git a/common/brd b/common/brd
> new file mode 100644
> index 0000000..31e964f
> --- /dev/null
> +++ b/common/brd
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# brd helper functions
> +
> +. common/shellcheck
> +
> +_have_brd() {
> +	_have_module brd
> +}
> +
> +_init_brd() {
> +	# _have_brd loads brd, we need to wait a bit for brd to be not in use in
> +	# order to reload it
> +	sleep 0.2
> +
> +	if ! modprobe -r brd || ! modprobe brd "$@" ; then
> +		echo "failed to reload brd with args: $*"
> +		return 1
> +	fi
> +
> +	return 0
> +}
> +
> +_cleanup_brd() {
> +	modprobe -r brd
> +}
> diff --git a/tests/md/001 b/tests/md/001
> new file mode 100755
> index 0000000..e9578e8
> --- /dev/null
> +++ b/tests/md/001
> @@ -0,0 +1,85 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# The bug is "visible" only when the underlying device of the raid is a network
> +# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the network device.
> +#
> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
> +
> +. tests/md/rc
> +. common/brd
> +. common/nvme
> +
> +DESCRIPTION="Raid with bitmap on tcp nvmet with opt-io-size over bitmap size"
> +QUICK=1
> +
> +#restrict test to nvme-tcp only
> +nvme_trtype=tcp
> +nvmet_blkdev_type="device"
> +
> +requires() {
> +	# Require dm-stripe
> +	_have_program dmsetup
> +	_have_driver dm-mod
> +
> +	_require_nvme_trtype tcp
> +	_have_brd
> +}
> +
> +# Sets up a brd device of 1G with optimal-io-size of 256K
> +setup_underlying_device() {
> +	if ! _init_brd rd_size=1048576 rd_nr=1; then
> +		return 1
> +	fi
> +
> +	dmsetup create ram0_big_optio --table \
> +		"0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
> +}
> +
> +cleanup_underlying_device() {
> +	dmsetup remove ram0_big_optio
> +	_cleanup_brd
> +}

This is okay for now, however, it'll will be greate to add a common
helper in rc, so that other test can reuse this in fulture.
> +
> +# Sets up a local host nvme over tcp
> +setup_nvme_over_tcp() {
> +	_setup_nvmet
> +
> +	local port
> +	port="$(_create_nvmet_port "${nvme_trtype}")"
> +
> +	_create_nvmet_subsystem "${def_subsysnqn}" "/dev/mapper/ram0_big_optio" "${def_subsys_uuid}"
> +	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +
> +	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +
> +	_nvme_connect_subsys
> +}
> +
> +cleanup_nvme_over_tcp() {
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup --subsysnqn "${def_subsysnqn}"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	setup_underlying_device
> +	setup_nvme_over_tcp
> +
> +	local ns
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +
> +	# Hangs here without the fix
> +	mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
> +		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
> +		/dev/"${ns}" missing

Perhaps add raid1 to requires()?
> +
> +	mdadm --quiet --stop /dev/md/blktests_md
> +	cleanup_nvme_over_tcp
> +	cleanup_underlying_device
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/md/001.out b/tests/md/001.out
> new file mode 100644
> index 0000000..23071ec
> --- /dev/null
> +++ b/tests/md/001.out
> @@ -0,0 +1,3 @@
> +Running md/001
> +disconnected 1 controller(s)
> +Test complete
> diff --git a/tests/md/rc b/tests/md/rc
> new file mode 100644
> index 0000000..d492579
> --- /dev/null
> +++ b/tests/md/rc
> @@ -0,0 +1,12 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Ofir Gal
> +#
> +# Tests for md raid
> +
> +. common/rc
> +
> +group_requires() {
> +	_have_root
> +	_have_program mdadm
> +}

And md-mod here.

It's nice to start adding md tests here.

Thanks,
Kuai
> 

