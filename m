Return-Path: <kt0755@gmail.com>
MIME-Version: 1.0
From: Kyungtae Kim <kt0755@gmail.com>
Date: Tue, 23 Oct 2018 08:20:22 +0900
Message-ID: <CAEAjamtML1yMLL0DsV5JkD1H6P0Yg19F2DVq+_c-u09RaCKuDw@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
To: axboe@kernel.dk, jikos@kernel.org
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong <threeearcat@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Content-Type: multipart/alternative; boundary="000000000000ed96770578d97f66"
List-ID: <linux-block@vger.kernel.org>

--000000000000ed96770578d97f66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We report a bug found in v4.19-rc2 (v4.19-rc8 as well):
UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32

kernel config: https://kt0755.github.io/etc/config_v2-4.19
repro: https://kt0755.github.io/etc/repro.b4076.c

Analysis:

struct floppy_raw_cmd {
   unsigned char cmd_count;
   unsigned char cmd[16];
  ...
};

for (i=3D0; i<raw_cmd->cmd_count; i++)
    output_byte(raw_cmd->cmd[i])

In driver/block/floppy.c:1495, the code snippet above is trying to
write some bytes to the floppy disk controller, depending on "cmd_count".
As you see "struct floppy_raw_cmd" above, the size of array =E2=80=9Ccmd=E2=
=80=9D is
fixed as 16.
The thing is, there is no boundary check for the index of array "cmd"
when this is used. Besides, "cmd_count" can be manipulated by raw_cmd_ioctl
which is derived from ioctl system call.
We observed that cmd_count is set at line 2540 (or 2111), but that is
after such a bug arose in our experiment. So by manipulating system call
ioctl,
user program can have illegitimate memory access.

The following is a simple patch to stop this. (This might not be the
best.)

diff --git a/linux-4.19-rc2/drivers/block/floppy.c
b/linux-4.19-rc2/drivers/block/floppy.c
index f2b6f4d..a3610c9 100644
--- a/linux-4.19-rc2/drivers/block/floppy.c
+++ b/linux-4.19-rc2/drivers/block/floppy.c
@@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user *param=
,
                         */
                return -EINVAL;

+       if (ptr->cmd_count > ARRAY_SIZE(ptr->cmd)) {
+               return -EINVAL;
+
        for (i =3D 0; i < 16; i++)
                ptr->reply[i] =3D 0;
        ptr->resultcode =3D 0;


Crash log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32
index 16 is out of range for type 'unsigned char [16]'
CPU: 0 PID: 2420 Comm: kworker/u4:3 Not tainted 4.19.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/201=
1
Workqueue: floppy fd_timer_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x94 lib/ubsan.c:159
 __ubsan_handle_out_of_bounds+0x174/0x1b8 lib/ubsan.c:386
 setup_rw_floppy+0xbd9/0xe60 drivers/block/floppy.c:1495
 seek_floppy drivers/block/floppy.c:1605 [inline]
 floppy_ready+0x61a/0x2230 drivers/block/floppy.c:1917
 fd_timer_workfn+0x1a/0x20 drivers/block/floppy.c:994
 process_one_work+0xa0c/0x1820 kernel/workqueue.c:2153
 worker_thread+0x8f/0xd20 kernel/workqueue.c:2296
 kthread+0x3a3/0x470 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--000000000000ed96770578d97f66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>We report a bug found in v4.19-rc2 (v4.19-rc8 as well):<br>
UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32<br>
<br>
kernel config: <a href=3D"https://kt0755.github.io/etc/config_v2-4.19" rel=
=3D"noreferrer" target=3D"_blank">https://kt0755.github.io/etc/config_v2-4.=
19</a><br>
repro: <a href=3D"https://kt0755.github.io/etc/repro.b4076.c" rel=3D"norefe=
rrer" target=3D"_blank">https://kt0755.github.io/etc/repro.b4076.c</a><br>
<br>
Analysis:<br>
<br>
struct floppy_raw_cmd {<br>
=C2=A0 =C2=A0unsigned char cmd_count;<br>
=C2=A0 =C2=A0unsigned char cmd[16];<br>
=C2=A0 ...<br>
};<br>
<br>
for (i=3D0; i&lt;raw_cmd-&gt;cmd_count; i++)<br>
=C2=A0 =C2=A0 output_byte(raw_cmd-&gt;cmd[i])<br>
<br>
In driver/block/floppy.c:1495, the code snippet above is trying to<br>
write some bytes to the floppy disk controller, depending on &quot;cmd_coun=
t&quot;.<br>
As you see &quot;struct floppy_raw_cmd&quot; above, the size of array =E2=
=80=9Ccmd=E2=80=9D is<br>
fixed as 16.<br>
The thing is, there is no boundary check for the index of array &quot;cmd&q=
uot;<br>
when this is used. Besides, &quot;cmd_count&quot; can be manipulated by raw=
_cmd_ioctl<br>
which is derived from ioctl system call.<br>
We observed that cmd_count is set at line 2540 (or 2111), but that is<br>
after such a bug arose in our experiment. So by manipulating system call io=
ctl,<br>
user program can have illegitimate memory access.<br>
<br>
The following is a simple patch to stop this. (This might not be the<br>
best.)<br>
<br>
diff --git a/linux-4.19-rc2/drivers/block/floppy.c<br>
b/linux-4.19-rc2/drivers/block/floppy.c<br>
index f2b6f4d..a3610c9 100644<br>
--- a/linux-4.19-rc2/drivers/block/floppy.c<br>
+++ b/linux-4.19-rc2/drivers/block/floppy.c<br>
@@ -3149,6 +3149,8 @@ static int raw_cmd_copyin(int cmd, void __user *param=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ptr-&gt;cmd_count &gt; ARRAY_SIZE(ptr-&gt;c=
md)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; 16; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr-&gt;reply[i] =
=3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr-&gt;resultcode =3D 0;<br>
<br>
<br>
Crash log<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
UBSAN: Undefined behaviour in drivers/block/floppy.c:1495:32<br>
index 16 is out of range for type &#39;unsigned char [16]&#39;<br>
CPU: 0 PID: 2420 Comm: kworker/u4:3 Not tainted 4.19.0-rc2 #1<br>
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/201=
1<br>
Workqueue: floppy fd_timer_workfn<br>
Call Trace:<br>
=C2=A0__dump_stack lib/dump_stack.c:77 [inline]<br>
=C2=A0dump_stack+0xd2/0x148 lib/dump_stack.c:113<br>
=C2=A0ubsan_epilogue+0x12/0x94 lib/ubsan.c:159<br>
=C2=A0__ubsan_handle_out_of_bounds+0x174/0x1b8 lib/ubsan.c:386<br>
=C2=A0setup_rw_floppy+0xbd9/0xe60 drivers/block/floppy.c:1495<br>
=C2=A0seek_floppy drivers/block/floppy.c:1605 [inline]<br>
=C2=A0floppy_ready+0x61a/0x2230 drivers/block/floppy.c:1917<br>
=C2=A0fd_timer_workfn+0x1a/0x20 drivers/block/floppy.c:994<br>
=C2=A0process_one_work+0xa0c/0x1820 kernel/workqueue.c:2153<br>
=C2=A0worker_thread+0x8f/0xd20 kernel/workqueue.c:2296<br>
=C2=A0kthread+0x3a3/0x470 kernel/kthread.c:246<br>
=C2=A0ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:413<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
</div>

--000000000000ed96770578d97f66--
