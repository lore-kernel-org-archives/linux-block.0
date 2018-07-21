Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64534 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUWXe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Jul 2018 18:23:34 -0400
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 2/2] blktests: add test for ANA state transition
Date: Sat, 21 Jul 2018 21:29:19 +0000
Message-ID: <BYAPR04MB450272E60922653AFF77D47B86500@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <20180717133118.39026-1-hare@suse.de>,<20180717133118.39026-3-hare@suse.de>
In-Reply-To: <20180717133118.39026-3-hare@suse.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: linux-block-owner@vger.kernel.org <linux-block-owner@vger.kernel.org>=
 on behalf of Hannes Reinecke <hare@suse.de>
Sent: Tuesday, July 17, 2018 6:31 AM
To: Omar Sandoval
Cc: Christoph Hellwig; Sagi Grimberg; Keith Busch; linux-nvme@lists.infrade=
ad.org; linux-block@vger.kernel.org; Hannes Reinecke; Hannes Reinecke
Subject: [PATCH 2/2] blktests: add test for ANA state transition
=A0=20
=20
Signed-off-by: Hannes Reinecke <hare@suse.com>
---
=A0tests/nvme/014=A0=A0=A0=A0 | 158 +++++++++++++++++++++++++++++++++++++++=
++++++++++++++
=A0tests/nvme/014.out |=A0 17 ++++++
=A02 files changed, 175 insertions(+)
=A0create mode 100755 tests/nvme/014
=A0create mode 100644 tests/nvme/014.out

diff --git a/tests/nvme/014 b/tests/nvme/014
new file mode 100755
index 0000000..4b57229
--- /dev/null
+++ b/tests/nvme/014
@@ -0,0 +1,158 @@
+#!/bin/bash
+#
+# Regression test for ANA base support
+#
+# Copyright (C) 2018 Hannes Reinecke
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation, either version 3 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.=A0 If not, see <http://www.gnu.org/licenses/>.


Licenses - GNU Project - Free Software Foundation
www.gnu.org
Published software should be free software.To make it free software, you ne=
ed to release it under a free software license. We normally use the GNU Gen=
eral Public License (GNU GPL), specifying version 3 or any later version, b=
ut occasionally we use other free software licenses.

+
+. tests/nvme/rc
+
+DESCRIPTION=3D"test ANA optimized/transitioning/inaccessible support"
+QUICK=3D1
+
+switch_nvmet_anagroup() {
+=A0=A0=A0=A0=A0=A0 local port1=3D"$1"
+=A0=A0=A0=A0=A0=A0 local port2=3D"$2"
+=A0=A0=A0=A0=A0=A0 local mode=3D"$3"
+
+=A0=A0=A0=A0=A0=A0 echo "ANA state ${mode}"
+
+=A0=A0=A0=A0=A0=A0 if [ "${mode}" =3D "change" ] ; then
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt1}" "1" "change"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt1}" "2" "change"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt2}" "1" "change"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt2}" "2" "change"
+=A0=A0=A0=A0=A0=A0 elif [ "${mode}" =3D "failover" ] ; then
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt1}" "1" "inaccessible"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt1}" "2" "optimized"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt2}" "1" "optimized"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt2}" "2" "inaccessible"
+=A0=A0=A0=A0=A0=A0 else
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt1}" "1" "optimized"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt1}" "2" "inaccessible"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt2}" "1" "inaccessible"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _set_nvmet_anagroup_state "${po=
rt2}" "2" "optimized"
+=A0=A0=A0=A0=A0=A0 fi
+}
+
+_display_ana_state() {
+=A0=A0=A0=A0=A0=A0 local grpid state
[CK] Newliine here ?
+=A0=A0=A0=A0=A0=A0 for nvme in /sys/class/nvme/* ; do
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for c in ${nvme}/nvme* ; do
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ ! =
-d ${c} ] ; then
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 echo "${nvme##*/}: ANA disabled"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 continue
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 grpid=
=3D"$(cat "${c}/ana_grpid")"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state=
=3D"$(cat "${c}/ana_state")"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 echo "$=
{c##*/}: grpid ${grpid} state ${state}"
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 done
+=A0=A0=A0=A0=A0=A0 done
+}

I think we need to move above functions to the  ${BLKTESTS_HOME}/tests/nvme=
/rc.
+
+_switch_ana_states() {
+=A0=A0=A0=A0=A0=A0 local port1=3D$1
+=A0=A0=A0=A0=A0=A0 local port2=3D$2
+
[CK] Please remove the extra line.
+}
[CK] I was not able to find a caller for above function, I'm I missing some=
thing ?
+
+requires() {
+=A0=A0=A0=A0=A0=A0 _have_program nvme && _have_module nvme-loop && _have_m=
odule loop && \
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _have_configfs && _have_fio
[CK] Missing nvmet module from the above list.
+}

Can we split following test function into small routines, it will be easier=
 to review and
maintain?

+
+test() {
+=A0=A0=A0=A0=A0=A0 echo "Running ${TEST_NAME}"
+
+=A0=A0=A0=A0=A0=A0 modprobe nvmet
+=A0=A0=A0=A0=A0=A0 modprobe nvme-loop
+
+=A0=A0=A0=A0=A0=A0 local port1
+=A0=A0=A0=A0=A0=A0 port1=3D"$(_create_nvmet_port "loop")"
[CK] Can we initialize variables at the time of declaration or after declar=
ation of all the
variables ?
+=A0=A0=A0=A0=A0=A0 ag1=3D"$(_create_nvmet_anagroup "${port1}")"
[CK] Not sure if we need ag1 variable.

+
+=A0=A0=A0=A0=A0=A0 local port2
[CK] Can we plese declare all the variable at the top please see tests/nvme=
/006-013
to maintain uniform style ?
+=A0=A0=A0=A0=A0=A0 port2=3D"$(_create_nvmet_port "loop")"
+=A0=A0=A0=A0=A0=A0 ag2=3D"$(_create_nvmet_anagroup "${port2}")"
+
+=A0=A0=A0=A0=A0=A0 truncate -s 1G "$TMPDIR/img1"
+
+=A0=A0=A0=A0=A0=A0 local loop_dev1
+=A0=A0=A0=A0=A0=A0 loop_dev1=3D"$(losetup -f --show "$TMPDIR/img1")"
+
+=A0=A0=A0=A0=A0=A0 _create_nvmet_subsystem "blktests-subsystem-1" "${loop_=
dev1}" \
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "91fdba0d-f87b-4c25-b80f-db7be1=
418b9e" "1"
+
+=A0=A0=A0=A0=A0=A0 truncate -s 1G "$TMPDIR/img2"
+
[CK] Do we really need img2 ? is it possible to use the img1 as we are not =
doing data verification ?
+=A0=A0=A0=A0=A0=A0 local loop_dev2
+=A0=A0=A0=A0=A0=A0 loop_dev2=3D"$(losetup -f --show "$TMPDIR/img2")"
+
+=A0=A0=A0=A0=A0=A0 _create_nvmet_ns "blktests-subsystem-1" "2" "${loop_dev=
2}" \
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "9aed0138-bfd9-46f5-92ac-24c703=
77fd49" "2"
+
+=A0=A0=A0=A0=A0=A0 _add_nvmet_subsys_to_port "${port1}" "blktests-subsyste=
m-1"
+=A0=A0=A0=A0=A0=A0 _add_nvmet_subsys_to_port "${port2}" "blktests-subsyste=
m-1"
+
+=A0=A0=A0=A0=A0=A0 switch_nvmet_anagroup "${port1}" "${port2}" failback
+
+=A0=A0=A0=A0=A0=A0 nvme connect -t loop -a "${port1}" -n blktests-subsyste=
m-1
+=A0=A0=A0=A0=A0=A0 nvme connect -t loop -a "${port2}" -n blktests-subsyste=
m-1
+
+=A0=A0=A0=A0=A0=A0 _display_ana_state
+
+=A0=A0=A0=A0=A0=A0 _run_fio_rand_io --size=3D256m --filename=3D"/dev/nvme0=
n1" &
[CK] Hardcoded value for ns, on my machine I have PCIe ns with "/dev/nvme0n=
1",
can we please make sure this is the right block device for the namespace th=
at we just
configured ?
+=A0=A0=A0=A0=A0=A0 trap "kill $!" EXIT
+
+=A0=A0=A0=A0=A0=A0 sleep 10
+
+=A0=A0=A0=A0=A0=A0 switch_nvmet_anagroup "${port1}" "${port2}" "change"
+
+=A0=A0=A0=A0=A0=A0 # Insert a delay to allow the AEN to be processed
+=A0=A0=A0=A0=A0=A0 sleep 1
+
+=A0=A0=A0=A0=A0=A0 _display_ana_state
+
+=A0=A0=A0=A0=A0=A0 sleep 6
+
+=A0=A0=A0=A0=A0=A0 switch_nvmet_anagroup "${port1}" "${port2}" "failover"
+
+=A0=A0=A0=A0=A0=A0 # Insert a delay to allow the AEN to be processed
+=A0=A0=A0=A0=A0=A0 sleep 1
+
+=A0=A0=A0=A0=A0=A0 _display_ana_state
+
+=A0=A0=A0=A0=A0=A0 wait
+=A0=A0=A0=A0=A0=A0 trap - EXIT
+
+=A0=A0=A0=A0=A0=A0 nvme disconnect -n blktests-subsystem-1
+
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_subsystem_from_port "${port1}" "blktests-=
subsystem-1"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_subsystem_from_port "${port2}" "blktests-=
subsystem-1"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_ns "blktests-subsystem-1" "2"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_subsystem "blktests-subsystem-1"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_anagroup "${port1}" "2"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_port "${port1}"
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_anagroup "${port2}" "2"
[CK] Plase make the groupid local varible instead of hard coding "2".
+=A0=A0=A0=A0=A0=A0 _remove_nvmet_port "${port2}"
+=A0=A0=A0=A0=A0=A0 losetup -d "$loop_dev2"
+=A0=A0=A0=A0=A0=A0 rm "$TMPDIR/img2"
+=A0=A0=A0=A0=A0=A0 losetup -d "$loop_dev1"
+=A0=A0=A0=A0=A0=A0 rm "$TMPDIR/img1"
+
+=A0=A0=A0=A0=A0=A0 modprobe -r nvme-loop
+=A0=A0=A0=A0=A0=A0 modprobe -r nvmet
+=A0=A0=A0=A0=A0=A0 echo "Test complete"
+}
diff --git a/tests/nvme/014.out b/tests/nvme/014.out
new file mode 100644
index 0000000..0a6ed35
--- /dev/null
+++ b/tests/nvme/014.out
@@ -0,0 +1,17 @@
+Running nvme/016
+nvme0c1n1: grpid 1 state optimized
+nvme0c1n2: grpid 2 state inaccessible
+nvme0c2n1: grpid 1 state inaccessible
+nvme0c2n2: grpid 2 state optimized
+ANA state transition
+nvme0c1n1: grpid 1 state change
+nvme0c1n2: grpid 2 state change
+nvme0c2n1: grpid 1 state change
+nvme0c2n2: grpid 2 state change
+ANA state failover
+nvme0c1n1: grpid 1 state inaccessible
+nvme0c1n2: grpid 2 state optimized
+nvme0c2n1: grpid 1 state optimized
+nvme0c2n2: grpid 2 state inaccessible
+NQN:blktests-subsystem-1 disconnected 2 controller(s)
+Test complete
--=20
2.12.3

    =
