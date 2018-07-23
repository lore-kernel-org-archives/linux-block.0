Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36166 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388102AbeGWPPu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jul 2018 11:15:50 -0400
Subject: Re: [PATCH 2/2] blktests: add test for ANA state transition
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "osandov@osandov.com" <osandov@osandov.com>
References: <20180717133118.39026-1-hare@suse.de>
 <20180717133118.39026-3-hare@suse.de>
 <BYAPR04MB450272E60922653AFF77D47B86500@BYAPR04MB4502.namprd04.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b7bfab15-4901-ae79-6812-20d9c2866ee2@suse.de>
Date: Mon, 23 Jul 2018 16:14:18 +0200
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB450272E60922653AFF77D47B86500@BYAPR04MB4502.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/21/2018 11:29 PM, Chaitanya Kulkarni wrote:
> From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org> on behalf of Hannes Reinecke <hare@suse.de>
> Sent: Tuesday, July 17, 2018 6:31 AM
> To: Omar Sandoval
> Cc: Christoph Hellwig; Sagi Grimberg; Keith Busch; linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; Hannes Reinecke; Hannes Reinecke
> Subject: [PATCH 2/2] blktests: add test for ANA state transition
>    
>   
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>   tests/nvme/014     | 158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/nvme/014.out |  17 ++++++
>   2 files changed, 175 insertions(+)
>   create mode 100755 tests/nvme/014
>   create mode 100644 tests/nvme/014.out
> 
> diff --git a/tests/nvme/014 b/tests/nvme/014
> new file mode 100755
> index 0000000..4b57229
> --- /dev/null
> +++ b/tests/nvme/014
> @@ -0,0 +1,158 @@
> +#!/bin/bash
> +#
> +# Regression test for ANA base support
> +#
> +# Copyright (C) 2018 Hannes Reinecke
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation, either version 3 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> 
> 
> Licenses - GNU Project - Free Software Foundation
> www.gnu.org
> Published software should be free software.To make it free software, you need to release it under
> a free software license. We normally use the GNU General Public License (GNU GPL), specifying version 3
> or any later version, but occasionally we use other free software licenses.
> 
I don't mind, I just copied it over from testcase 10...

> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
> +QUICK=1
> +
> +switch_nvmet_anagroup() {
> +       local port1="$1"
> +       local port2="$2"
> +       local mode="$3"
> +
> +       echo "ANA state ${mode}"
> +
> +       if [ "${mode}" = "change" ] ; then
> +               _set_nvmet_anagroup_state "${port1}" "1" "change"
> +               _set_nvmet_anagroup_state "${port1}" "2" "change"
> +               _set_nvmet_anagroup_state "${port2}" "1" "change"
> +               _set_nvmet_anagroup_state "${port2}" "2" "change"
> +       elif [ "${mode}" = "failover" ] ; then
> +               _set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
> +               _set_nvmet_anagroup_state "${port1}" "2" "optimized"
> +               _set_nvmet_anagroup_state "${port2}" "1" "optimized"
> +               _set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
> +       else
> +               _set_nvmet_anagroup_state "${port1}" "1" "optimized"
> +               _set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
> +               _set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
> +               _set_nvmet_anagroup_state "${port2}" "2" "optimized"
> +       fi
> +}
> +
> +_display_ana_state() {
> +       local grpid state
> [CK] Newliine here ?

Okay

> +       for nvme in /sys/class/nvme/* ; do
> +               for c in ${nvme}/nvme* ; do
> +                       if [ ! -d ${c} ] ; then
> +                               echo "${nvme##*/}: ANA disabled"
> +                               continue
> +                       fi
> +                       grpid="$(cat "${c}/ana_grpid")"
> +                       state="$(cat "${c}/ana_state")"
> +                       echo "${c##*/}: grpid ${grpid} state ${state}"
> +               done
> +       done
> +}
> 
> I think we need to move above functions to the  ${BLKTESTS_HOME}/tests/nvme/rc.

Okay, can do.

> +
> +_switch_ana_states() {
> +       local port1=$1
> +       local port2=$2
> +
> [CK] Please remove the extra line.
> +}
> [CK] I was not able to find a caller for above function, I'm I missing something ?
> +
Yeah, that's an older function which got left over during refactoring.

> +requires() {
> +       _have_program nvme && _have_module nvme-loop && _have_module loop && \
> +               _have_configfs && _have_fio
> [CK] Missing nvmet module from the above list.
> +}
> 
> Can we split following test function into small routines, it will be easier to review and
> maintain?
> 
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +
> +       modprobe nvmet
> +       modprobe nvme-loop
> +
> +       local port1
> +       port1="$(_create_nvmet_port "loop")"
> [CK] Can we initialize variables at the time of declaration or after declaration of all the
> variables ?

Sure. But we should do it consistently; the older tests also do not 
follow these rules...

> +       ag1="$(_create_nvmet_anagroup "${port1}")"
> [CK] Not sure if we need ag1 variable.
> 
Yeah, it's more for symmetry than anything else.

> +
> +       local port2
> [CK] Can we plese declare all the variable at the top please see tests/nvme/006-013
> to maintain uniform style ?

Sure. But see above; not all tests follow the same scheme.

> +       port2="$(_create_nvmet_port "loop")"
> +       ag2="$(_create_nvmet_anagroup "${port2}")"
> +
> +       truncate -s 1G "$TMPDIR/img1"
> +
> +       local loop_dev1
> +       loop_dev1="$(losetup -f --show "$TMPDIR/img1")"
> +
> +       _create_nvmet_subsystem "blktests-subsystem-1" "${loop_dev1}" \
> +               "91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
> +
> +       truncate -s 1G "$TMPDIR/img2"
> +
> [CK] Do we really need img2 ? is it possible to use the img1 as we are not doing data verification ?

Yes. There's an issue with the current implementation which fails to 
signal a namespace state change for the _second_ namepsace.

(That's the one patch I've sent to the current ANA implementation from hch)

> +       local loop_dev2
> +       loop_dev2="$(losetup -f --show "$TMPDIR/img2")"
> +
> +       _create_nvmet_ns "blktests-subsystem-1" "2" "${loop_dev2}" \
> +               "9aed0138-bfd9-46f5-92ac-24c70377fd49" "2"
> +
> +       _add_nvmet_subsys_to_port "${port1}" "blktests-subsystem-1"
> +       _add_nvmet_subsys_to_port "${port2}" "blktests-subsystem-1"
> +
> +       switch_nvmet_anagroup "${port1}" "${port2}" failback
> +
> +       nvme connect -t loop -a "${port1}" -n blktests-subsystem-1
> +       nvme connect -t loop -a "${port2}" -n blktests-subsystem-1
> +
> +       _display_ana_state
> +
> +       _run_fio_rand_io --size=256m --filename="/dev/nvme0n1" &
> [CK] Hardcoded value for ns, on my machine I have PCIe ns with "/dev/nvme0n1",
> can we please make sure this is the right block device for the namespace that we just
> configured ?

Yeah, I know. Will see what I can do.

> +       trap "kill $!" EXIT
> +
> +       sleep 10
> +
> +       switch_nvmet_anagroup "${port1}" "${port2}" "change"
> +
> +       # Insert a delay to allow the AEN to be processed
> +       sleep 1
> +
> +       _display_ana_state
> +
> +       sleep 6
> +
> +       switch_nvmet_anagroup "${port1}" "${port2}" "failover"
> +
> +       # Insert a delay to allow the AEN to be processed
> +       sleep 1
> +
> +       _display_ana_state
> +
> +       wait
> +       trap - EXIT
> +
> +       nvme disconnect -n blktests-subsystem-1
> +
> +       _remove_nvmet_subsystem_from_port "${port1}" "blktests-subsystem-1"
> +       _remove_nvmet_subsystem_from_port "${port2}" "blktests-subsystem-1"
> +       _remove_nvmet_ns "blktests-subsystem-1" "2"
> +       _remove_nvmet_subsystem "blktests-subsystem-1"
> +       _remove_nvmet_anagroup "${port1}" "2"
> +       _remove_nvmet_port "${port1}"
> +       _remove_nvmet_anagroup "${port2}" "2"
> [CK] Plase make the groupid local varible instead of hard coding "2".

Hmm. Not easy. But I'll have a look.

Thanks for the review.

Cheers,

Hannes
