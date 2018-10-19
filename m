Return-Path: <valdis@vt.edu>
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
To: Dennis Zhou <dennis@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-Reply-To: <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu> <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com> <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com> <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539964356_3102P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Oct 2018 11:52:36 -0400
Message-ID: <14614.1539964356@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

--==_Exmh_1539964356_3102P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1539962862_31020"

This is a multipart MIME message.

--==_Exmh_1539962862_31020
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Oct 2018 17:20:29 -0400, Dennis Zhou said:
>
> I apologize, but I'm having a hard time reproducing this myself. I am
> not able to hit this issue in my qemu instance with linux-next built
> with your config. I have been running 'rpm -Hvh --force fio.rpm' severa=
l
> times and haven't seen the issue.

I wouldn't be surprised if there's something oddball in my system config
that changes the situation.

> Would it be possible for you to create a minimal qemu image that
> reproduces the issue as I'm having issues reproducing it with my setup?=


Hmm.. I'd first have to figure out how to build a qemu image at all..

> Additionally, I've added some more debug text in the diff below. If you=

> could apply that and send me the full dmesg that would be great. Lastly=
,
> can you just confirm for me that the commit before, f0fcb3ec89f3
> =22blkcg: remove additional reference to the css=22, isn't seeing this
> issue?

Full dmesg attached.  Had to piece it together from a 'dmesg' and what
got saved in pstore when it crashed.  I was surprised that the printk_onc=
e
popped during very early boot (2.88 seconds in), and then only 2 lines of=
 output
right before the crash:

=5B  106.465848=5D audit: type=3D1130 audit(1539957798.984:101): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:syst
em_r:init_t:s0-s15:c0.c1023 msg=3D'unit=3Drun-r93ac4731e4724fd6a3670e7d0c=
417522 comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd
=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B  106.564711=5D dennis: q ffff9e3c57152000 =21=3D rl->q ffff9e3a8fe480=
40
=5B  106.564713=5D dennis: bio: ffff9e3a8fcf5400, root: ffffffffbbdd89e0
=5B  106.564761=5D BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000000
=5B  106.568786=5D PGD 0 P4D 0
=5B  106.570761=5D Oops: 0000 =5B=231=5D PREEMPT SMP PTI
=5B  106.573115=5D CPU: 2 PID: 1205 Comm: sh Tainted: G                T =
4.19.0-rc8-next-20181016-dirty =23639

I'll cook up a kernel checked out at that commit and test later today...

--==_Exmh_1539962862_31020
Content-Type: text/plain ; name="dmesg.all"; charset=iso-8859-1
Content-Description: dmesg.all
Content-Disposition: attachment; filename="dmesg.all"
Content-Transfer-Encoding: quoted-printable

=5B    0.000000=5D microcode: microcode updated early to revision 0x20, d=
ate =3D 2018-04-10
=5B    0.000000=5D Linux version 4.19.0-rc8-next-20181016-dirty (source=
=40turing-police.cc.vt.edu) (gcc version 8.2.1 20181011 (Red Hat 8.2.1-4)=
 (GCC)) =23639 SMP PREEMPT Wed Oct 17 18:02:07 EDT 2018
=5B    0.000000=5D Command line: BOOT_IMAGE=3D/vmlinuz-4.19.0-rc8-next-20=
181016-dirty root=3D/dev/mapper/turing--police-root ro rd.md=3D0 rd.dm=3D=
0 rd.lvm.lv=3Dturing-police/00 console.keymap=3D rd.luks.uuid=3Dluks-665b=
b147-9e39-4003-b3ae-7be925f51a97 rd.lvm.lv=3Dturing-police/swap rd.lvm.lv=
=3Dturing-police/root quiet LANG=3Den_US.UTF-8 nouveau.modeset=3D0 video=
=3Dvesa:off single
=5B    0.000000=5D KERNEL supported cpus:
=5B    0.000000=5D   Intel GenuineIntel
=5B    0.000000=5D x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating=
 point registers'
=5B    0.000000=5D x86/fpu: Supporting XSAVE feature 0x002: 'SSE register=
s'
=5B    0.000000=5D x86/fpu: Supporting XSAVE feature 0x004: 'AVX register=
s'
=5B    0.000000=5D x86/fpu: xstate_offset=5B2=5D:  576, xstate_sizes=5B2=
=5D:  256
=5B    0.000000=5D x86/fpu: Enabled xstate features 0x7, context size is =
832 bytes, using 'standard' format.
=5B    0.000000=5D BIOS-provided physical RAM map:
=5B    0.000000=5D BIOS-e820: =5Bmem 0x0000000000000000-0x000000000009eff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000000009f000-0x000000000009fff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x0000000000100000-0x00000000ca709ff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000ca70a000-0x00000000ca7ffff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000ca800000-0x00000000caf52ff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000caf53000-0x00000000cafffff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cb000000-0x00000000cb7b1ff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cb7b2000-0x00000000cb7ffff=
f=5D ACPI data
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cb800000-0x00000000ccefdff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000ccefe000-0x00000000ccfffff=
f=5D ACPI NVS
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cd000000-0x00000000ce59bff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000ce59c000-0x00000000cefa3ff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cefa4000-0x00000000cefe6ff=
f=5D ACPI NVS
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cefe7000-0x00000000cf2b0ff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cf2b1000-0x00000000cf7efff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000cf7f0000-0x00000000cf7ffff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000f8000000-0x00000000fbfffff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000fec00000-0x00000000fec00ff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000fed00000-0x00000000fed03ff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000fed1c000-0x00000000fed1fff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000fee00000-0x00000000fee00ff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x00000000ff000000-0x00000000fffffff=
f=5D reserved
=5B    0.000000=5D BIOS-e820: =5Bmem 0x0000000100000000-0x000000040dfacff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000040dfad000-0x000000040dfadff=
f=5D unusable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000040dfae000-0x000000040dfaeff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000040dfaf000-0x000000040dfafff=
f=5D unusable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000040dfb0000-0x000000040dfeaff=
f=5D usable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000040dfeb000-0x000000040dfebff=
f=5D unusable
=5B    0.000000=5D BIOS-e820: =5Bmem 0x000000040dfec000-0x000000042dfffff=
f=5D usable
=5B    0.000000=5D NX (Execute Disable) protection: active
=5B    0.000000=5D e820: update =5Bmem 0xc7a9a018-0xc7ab6e57=5D usable =
=3D=3D> usable
=5B    0.000000=5D e820: update =5Bmem 0xc7a9a018-0xc7ab6e57=5D usable =
=3D=3D> usable
=5B    0.000000=5D e820: update =5Bmem 0xc7a8a018-0xc7a99c57=5D usable =
=3D=3D> usable
=5B    0.000000=5D e820: update =5Bmem 0xc7a8a018-0xc7a99c57=5D usable =
=3D=3D> usable
=5B    0.000000=5D extended physical RAM map:
=5B    0.000000=5D reserve setup_data: =5Bmem 0x0000000000000000-0x000000=
000009efff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000000009f000-0x000000=
000009ffff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x0000000000100000-0x000000=
00c7a8a017=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000c7a8a018-0x000000=
00c7a99c57=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000c7a99c58-0x000000=
00c7a9a017=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000c7a9a018-0x000000=
00c7ab6e57=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000c7ab6e58-0x000000=
00ca709fff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000ca70a000-0x000000=
00ca7fffff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000ca800000-0x000000=
00caf52fff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000caf53000-0x000000=
00caffffff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cb000000-0x000000=
00cb7b1fff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cb7b2000-0x000000=
00cb7fffff=5D ACPI data
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cb800000-0x000000=
00ccefdfff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000ccefe000-0x000000=
00ccffffff=5D ACPI NVS
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cd000000-0x000000=
00ce59bfff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000ce59c000-0x000000=
00cefa3fff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cefa4000-0x000000=
00cefe6fff=5D ACPI NVS
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cefe7000-0x000000=
00cf2b0fff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cf2b1000-0x000000=
00cf7effff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000cf7f0000-0x000000=
00cf7fffff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000f8000000-0x000000=
00fbffffff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000fec00000-0x000000=
00fec00fff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000fed00000-0x000000=
00fed03fff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000fed1c000-0x000000=
00fed1ffff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000fee00000-0x000000=
00fee00fff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x00000000ff000000-0x000000=
00ffffffff=5D reserved
=5B    0.000000=5D reserve setup_data: =5Bmem 0x0000000100000000-0x000000=
040dfacfff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000040dfad000-0x000000=
040dfadfff=5D unusable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000040dfae000-0x000000=
040dfaefff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000040dfaf000-0x000000=
040dfaffff=5D unusable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000040dfb0000-0x000000=
040dfeafff=5D usable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000040dfeb000-0x000000=
040dfebfff=5D unusable
=5B    0.000000=5D reserve setup_data: =5Bmem 0x000000040dfec000-0x000000=
042dffffff=5D usable
=5B    0.000000=5D efi: EFI v2.31 by American Megatrends
=5B    0.000000=5D efi:  ACPI=3D0xcb7f1000  ACPI 2.0=3D0xcb7f1000  SMBIOS=
=3D0xf04c0  MPS=3D0xfd6d0=20
=5B    0.000000=5D SMBIOS 2.7 present.
=5B    0.000000=5D DMI: Dell Inc. Latitude E6530/07Y85M, BIOS A21 02/21/2=
018
=5B    0.000000=5D tsc: Fast TSC calibration using PIT
=5B    0.000000=5D tsc: Detected 2691.391 MHz processor
=5B    0.002646=5D e820: update =5Bmem 0x00000000-0x00000fff=5D usable =
=3D=3D> reserved
=5B    0.002651=5D e820: remove =5Bmem 0x000a0000-0x000fffff=5D usable
=5B    0.002667=5D last_pfn =3D 0x42e000 max_arch_pfn =3D 0x400000000
=5B    0.002672=5D MTRR default type: uncachable
=5B    0.002675=5D MTRR fixed ranges enabled:
=5B    0.002678=5D   00000-9FFFF write-back
=5B    0.002680=5D   A0000-BFFFF uncachable
=5B    0.002682=5D   C0000-CFFFF write-protect
=5B    0.002685=5D   D0000-DFFFF uncachable
=5B    0.002687=5D   E0000-FFFFF write-protect
=5B    0.002690=5D MTRR variable ranges enabled:
=5B    0.002693=5D   0 base 000000000 mask C00000000 write-back
=5B    0.002696=5D   1 base 400000000 mask FE0000000 write-back
=5B    0.002698=5D   2 base 420000000 mask FF8000000 write-back
=5B    0.002701=5D   3 base 428000000 mask FFC000000 write-back
=5B    0.002704=5D   4 base 42C000000 mask FFE000000 write-back
=5B    0.002706=5D   5 base 0E0000000 mask FE0000000 uncachable
=5B    0.002709=5D   6 base 0D0000000 mask FF0000000 uncachable
=5B    0.002711=5D   7 disabled
=5B    0.002713=5D   8 disabled
=5B    0.002715=5D   9 disabled
=5B    0.005256=5D x86/PAT: Configuration =5B0-7=5D: WB  WC  UC- UC  WB  =
WP  UC- WT =20
=5B    0.009470=5D e820: update =5Bmem 0xd0000000-0xffffffff=5D usable =
=3D=3D> reserved
=5B    0.009479=5D last_pfn =3D 0xcf800 max_arch_pfn =3D 0x400000000
=5B    0.018463=5D found SMP MP-table at =5Bmem 0x000fda20-0x000fda2f=5D =
mapped at =5B(____ptrval____)=5D
=5B    0.018659=5D Base memory trampoline at =5B(____ptrval____)=5D 95000=
 size 24576
=5B    0.018672=5D BRK =5B0x250e01000, 0x250e01fff=5D PGTABLE
=5B    0.018676=5D BRK =5B0x250e02000, 0x250e02fff=5D PGTABLE
=5B    0.018678=5D BRK =5B0x250e03000, 0x250e03fff=5D PGTABLE
=5B    0.018736=5D BRK =5B0x250e04000, 0x250e04fff=5D PGTABLE
=5B    0.018741=5D BRK =5B0x250e05000, 0x250e05fff=5D PGTABLE
=5B    0.018981=5D BRK =5B0x250e06000, 0x250e06fff=5D PGTABLE
=5B    0.019579=5D BRK =5B0x250e07000, 0x250e07fff=5D PGTABLE
=5B    0.019740=5D BRK =5B0x250e08000, 0x250e08fff=5D PGTABLE
=5B    0.019902=5D BRK =5B0x250e09000, 0x250e09fff=5D PGTABLE
=5B    0.020010=5D BRK =5B0x250e0a000, 0x250e0afff=5D PGTABLE
=5B    0.020204=5D BRK =5B0x250e0b000, 0x250e0bfff=5D PGTABLE
=5B    0.020388=5D BRK =5B0x250e0c000, 0x250e0cfff=5D PGTABLE
=5B    0.023188=5D Secure boot disabled
=5B    0.023191=5D RAMDISK: =5Bmem 0x5f379000-0x6003efff=5D
=5B    0.023203=5D ACPI: Early table checksum verification disabled
=5B    0.023208=5D ACPI: RSDP 0x00000000CB7F1000 000024 (v02 DELL  )
=5B    0.023214=5D ACPI: XSDT 0x00000000CB7F1088 000094 (v01 DELL   CBX3 =
    01072009 AMI  00010013)
=5B    0.023223=5D ACPI: FACP 0x00000000CB7FB720 00010C (v05 DELL   CBX3 =
    01072009 AMI  00010013)
=5B    0.023233=5D ACPI: DSDT 0x00000000CB7F11B0 00A56F (v02 DELL   CBX3 =
    00000021 INTL 20091112)
=5B    0.023240=5D ACPI: FACS 0x00000000CCFED080 000040
=5B    0.023245=5D ACPI: APIC 0x00000000CB7FB830 000072 (v03 DELL   CBX3 =
    01072009 AMI  00010013)
=5B    0.023251=5D ACPI: FPDT 0x00000000CB7FB8A8 000044 (v01 DELL   CBX3 =
    01072009 AMI  00010013)
=5B    0.023257=5D ACPI: TCPA 0x00000000CB7FB8F0 000032 (v02 APTIO4 NAPAA=
SF  00000001 MSFT 01000013)
=5B    0.023263=5D ACPI: MCFG 0x00000000CB7FB928 00003C (v01 DELL   CBX3 =
    01072009 MSFT 00000097)
=5B    0.023269=5D ACPI: HPET 0x00000000CB7FB968 000038 (v01 DELL   CBX3 =
    01072009 AMI. 00000005)
=5B    0.023275=5D ACPI: SSDT 0x00000000CB7FB9A0 000415 (v01 SataRe SataT=
abl 00001000 INTL 20091112)
=5B    0.023281=5D ACPI: SSDT 0x00000000CB7FBDB8 0009B9 (v01 PmRef  Cpu0I=
st  00003000 INTL 20051117)
=5B    0.023287=5D ACPI: SSDT 0x00000000CB7FC778 000B22 (v01 PmRef  CpuPm=
    00003000 INTL 20051117)
=5B    0.023293=5D ACPI: DMAR 0x00000000CB7FD2A0 000080 (v01 INTEL  SNB  =
    00000001 INTL 00000001)
=5B    0.023299=5D ACPI: ASF=21 0x00000000CB7FD320 0000A5 (v32 INTEL   HC=
G     00000001 TFSM 000F4240)
=5B    0.023305=5D ACPI: SSDT 0x00000000CB7FD3C8 000579 (v01 AMITCG PROC =
    00000001 INTL 20051117)
=5B    0.023311=5D ACPI: BGRT 0x00000000CB7FD948 000038 (v00 ??          =
    01072009 AMI  00010013)
=5B    0.023317=5D ACPI: SSDT 0x00000000CB7FD980 00198A (v01 NvdRef NvdTa=
bl  00001000 INTL 20091112)
=5B    0.023329=5D ACPI: Local APIC address 0xfee00000
=5B    0.023418=5D Zone ranges:
=5B    0.023421=5D   DMA32    =5Bmem 0x0000000000001000-0x00000000fffffff=
f=5D
=5B    0.023424=5D   Normal   =5Bmem 0x0000000100000000-0x000000042dfffff=
f=5D
=5B    0.023428=5D Movable zone start for each node
=5B    0.023430=5D Early memory node ranges
=5B    0.023432=5D   node   0: =5Bmem 0x0000000000001000-0x000000000009ef=
ff=5D
=5B    0.023435=5D   node   0: =5Bmem 0x0000000000100000-0x00000000ca709f=
ff=5D
=5B    0.023437=5D   node   0: =5Bmem 0x00000000ca800000-0x00000000caf52f=
ff=5D
=5B    0.023440=5D   node   0: =5Bmem 0x00000000cb000000-0x00000000cb7b1f=
ff=5D
=5B    0.023442=5D   node   0: =5Bmem 0x00000000cb800000-0x00000000ccefdf=
ff=5D
=5B    0.023445=5D   node   0: =5Bmem 0x00000000cd000000-0x00000000ce59bf=
ff=5D
=5B    0.023447=5D   node   0: =5Bmem 0x00000000cefe7000-0x00000000cf2b0f=
ff=5D
=5B    0.023449=5D   node   0: =5Bmem 0x00000000cf7f0000-0x00000000cf7fff=
ff=5D
=5B    0.023452=5D   node   0: =5Bmem 0x0000000100000000-0x000000040dfacf=
ff=5D
=5B    0.023454=5D   node   0: =5Bmem 0x000000040dfae000-0x000000040dfaef=
ff=5D
=5B    0.023457=5D   node   0: =5Bmem 0x000000040dfb0000-0x000000040dfeaf=
ff=5D
=5B    0.023459=5D   node   0: =5Bmem 0x000000040dfec000-0x000000042dffff=
ff=5D
=5B    0.023578=5D Zeroed struct page in unavailable ranges: 6882 pages
=5B    0.023579=5D Initmem setup node 0 =5Bmem 0x0000000000001000-0x00000=
0042dffffff=5D
=5B    0.023583=5D On node 0 totalpages: 4179230
=5B    0.023587=5D   DMA32 zone: 13205 pages used for memmap
=5B    0.023589=5D   DMA32 zone: 28 pages reserved
=5B    0.023592=5D   DMA32 zone: 845089 pages, LIFO batch:63
=5B    0.045332=5D   Normal zone: 52096 pages used for memmap
=5B    0.045337=5D   Normal zone: 3334141 pages, LIFO batch:63
=5B    0.046400=5D ACPI: PM-Timer IO Port: 0x408
=5B    0.046407=5D ACPI: Local APIC address 0xfee00000
=5B    0.046417=5D ACPI: LAPIC_NMI (acpi_id=5B0xff=5D high edge lint=5B0x=
1=5D)
=5B    0.046444=5D IOAPIC=5B0=5D: apic_id 2, version 32, address 0xfec000=
00, GSI 0-23
=5B    0.046452=5D ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl df=
l)
=5B    0.046456=5D ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high l=
evel)
=5B    0.046461=5D ACPI: IRQ0 used by override.
=5B    0.046465=5D ACPI: IRQ9 used by override.
=5B    0.046470=5D Using ACPI (MADT) for SMP configuration information
=5B    0.046474=5D ACPI: HPET id: 0x8086a701 base: 0xfed00000
=5B    0.046483=5D smpboot: Allowing 4 CPUs, 0 hotplug CPUs
=5B    0.046603=5D =5Bmem 0xcf800000-0xf7ffffff=5D available for PCI devi=
ces
=5B    0.046611=5D clocksource: refined-jiffies: mask: 0xffffffff max_cyc=
les: 0xffffffff, max_idle_ns: 1910969940391419 ns
=5B    0.046637=5D random: get_random_bytes called from start_kernel+0xc4=
/0x7c7 with crng_init=3D0
=5B    0.046656=5D setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4=
 nr_node_ids:1
=5B    0.047933=5D percpu: Embedded 497 pages/cpu =40(____ptrval____) s19=
97336 r8192 d30184 u2097152
=5B    0.047957=5D pcpu-alloc: s1997336 r8192 d30184 u2097152 alloc=3D1*2=
097152
=5B    0.047960=5D pcpu-alloc: =5B0=5D 0 =5B0=5D 1 =5B0=5D 2 =5B0=5D 3=20
=5B    0.048018=5D Built 1 zonelists, mobility grouping on.  Total pages:=
 4113901
=5B    0.048025=5D Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.19.0-rc8-=
next-20181016-dirty root=3D/dev/mapper/turing--police-root ro rd.md=3D0 r=
d.dm=3D0 rd.lvm.lv=3Dturing-police/00 console.keymap=3D rd.luks.uuid=3Dlu=
ks-665bb147-9e39-4003-b3ae-7be925f51a97 rd.lvm.lv=3Dturing-police/swap rd=
.lvm.lv=3Dturing-police/root quiet LANG=3Den_US.UTF-8 nouveau.modeset=3D0=
 video=3Dvesa:off single
=5B    0.049032=5D Dentry cache hash table entries: 2097152 (order: 12, 1=
6777216 bytes)
=5B    0.049433=5D Inode-cache hash table entries: 1048576 (order: 11, 83=
88608 bytes)
=5B    0.148148=5D Memory: 3265348K/16716920K available (16388K kernel co=
de, 3959K rwdata, 4556K rodata, 3680K init, 14740K bss, 588548K reserved,=
 0K cma-reserved)
=5B    0.148342=5D Kernel/User page tables isolation: enabled
=5B    0.148408=5D ftrace: allocating 37150 entries in 146 pages
=5B    0.165544=5D Running RCU self tests
=5B    0.165548=5D rcu: Preemptible hierarchical RCU implementation.
=5B    0.165550=5D rcu: 	RCU lockdep checking is enabled.
=5B    0.165553=5D rcu: 	RCU debug extended QS entry/exit.
=5B    0.165555=5D 	Tasks RCU enabled.
=5B    0.165558=5D rcu: RCU calculated value of scheduler-enlistment dela=
y is 100 jiffies.
=5B    0.166544=5D NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
=5B    0.167131=5D Console: colour dummy device 160x64
=5B    0.167142=5D printk: console =5Btty0=5D enabled
=5B    0.167147=5D Lock dependency validator: Copyright (c) 2006 Red Hat,=
 Inc., Ingo Molnar
=5B    0.167150=5D ... MAX_LOCKDEP_SUBCLASSES:  8
=5B    0.167152=5D ... MAX_LOCK_DEPTH:          48
=5B    0.167154=5D ... MAX_LOCKDEP_KEYS:        8191
=5B    0.167157=5D ... CLASSHASH_SIZE:          4096
=5B    0.167159=5D ... MAX_LOCKDEP_ENTRIES:     32768
=5B    0.167161=5D ... MAX_LOCKDEP_CHAINS:      65536
=5B    0.167164=5D ... CHAINHASH_SIZE:          32768
=5B    0.167166=5D  memory used by lock dependency info: 7775 kB
=5B    0.167168=5D  per task-struct memory footprint: 2688 bytes
=5B    0.167177=5D ACPI: Core revision 20181003
=5B    0.167543=5D clocksource: hpet: mask: 0xffffffff max_cycles: 0xffff=
ffff, max_idle_ns: 133484882848 ns
=5B    0.167568=5D hpet clockevent registered
=5B    0.167581=5D APIC: Switch to symmetric I/O mode setup
=5B    0.167586=5D DMAR: Host address width 36
=5B    0.167589=5D DMAR: DRHD base: 0x000000fed90000 flags: 0x1
=5B    0.167606=5D DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c90080=
20660262 ecap f0105a
=5B    0.167609=5D DMAR: RMRR base: 0x000000ce712000 end: 0x000000ce731ff=
f
=5B    0.167614=5D DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU=
 0
=5B    0.167617=5D DMAR-IR: HPET id 0 under DRHD base 0xfed90000
=5B    0.167620=5D DMAR-IR: Queued invalidation will be enabled to suppor=
t x2apic and Intr-remapping.
=5B    0.167796=5D DMAR: DRHD: handling fault status reg 2
=5B    0.167824=5D DMAR: =5BDMA Read=5D Request device =5B00:1f.2=5D faul=
t addr ce6ce000 =5Bfault reason 06=5D PTE Read access is not set
=5B    0.167945=5D DMAR-IR: Enabled IRQ remapping in x2apic mode
=5B    0.167947=5D x2apic enabled
=5B    0.167961=5D Switched APIC routing to cluster x2apic.
=5B    0.168637=5D ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 p=
in2=3D-1
=5B    0.173581=5D clocksource: tsc-early: mask: 0xffffffffffffffff max_c=
ycles: 0x26cb79d2970, max_idle_ns: 440795288020 ns
=5B    0.173608=5D Calibrating delay loop (skipped), value calculated usi=
ng timer frequency.. 5382.78 BogoMIPS (lpj=3D2691391)
=5B    0.173613=5D pid_max: default: 32768 minimum: 301
=5B    0.174378=5D LSM: Security Framework initializing
=5B    0.174383=5D Yama: becoming mindful.
=5B    0.174398=5D SELinux:  Initializing.
=5B    0.174476=5D *** VALIDATE SELinux ***
=5B    0.174553=5D Mount-cache hash table entries: 32768 (order: 6, 26214=
4 bytes)
=5B    0.174609=5D Mountpoint-cache hash table entries: 32768 (order: 6, =
262144 bytes)
=5B    0.175074=5D *** VALIDATE proc ***
=5B    0.175287=5D *** VALIDATE cgroup1 ***
=5B    0.175291=5D *** VALIDATE cgroup2 ***
=5B    0.175331=5D ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
=5B    0.175334=5D ENERGY_PERF_BIAS: View and update with x86_energy_perf=
_policy(8)
=5B    0.175339=5D mce: CPU supports 7 MCE banks
=5B    0.175363=5D process: using mwait in idle threads
=5B    0.175368=5D Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
=5B    0.175371=5D Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB =
0
=5B    0.175375=5D Spectre V2 : Mitigation: Full generic retpoline
=5B    0.175378=5D Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filli=
ng RSB on context switch
=5B    0.175381=5D Spectre V2 : Spectre v2 mitigation: Enabling Indirect =
Branch Prediction Barrier
=5B    0.175383=5D Spectre V2 : Enabling Restricted Speculation for firmw=
are calls
=5B    0.175391=5D Spectre V2 : Spectre v2 cross-process SMT mitigation: =
Enabling STIBP
=5B    0.175398=5D Speculative Store Bypass: Mitigation: Speculative Stor=
e Bypass disabled via prctl and seccomp
=5B    0.175635=5D Freeing SMP alternatives memory: 36K
=5B    0.206056=5D TSC deadline timer enabled
=5B    0.206069=5D smpboot: CPU0: Intel(R) Core(TM) i5-3340M CPU =40 2.70=
GHz (family: 0x6, model: 0x3a, stepping: 0x9)
=5B    0.206206=5D random: get_random_bytes called from cpu_startup_entry=
+0x2d/0x75 with crng_init=3D0
=5B    0.211653=5D Performance Events: PEBS fmt1+, IvyBridge events, 16-d=
eep LBR, full-width counters, Intel PMU driver.
=5B    0.211688=5D ... version:                3
=5B    0.211691=5D ... bit width:              48
=5B    0.211694=5D ... generic registers:      4
=5B    0.211697=5D ... value mask:             0000ffffffffffff
=5B    0.211700=5D ... max period:             00007fffffffffff
=5B    0.211703=5D ... fixed-purpose events:   3
=5B    0.211706=5D ... event mask:             000000070000000f
=5B    0.213636=5D rcu: Hierarchical SRCU implementation.
=5B    0.216799=5D NMI watchdog: Enabled. Permanently consumes one hw-PMU=
 counter.
=5B    0.218646=5D smp: Bringing up secondary CPUs ...
=5B    0.226875=5D x86: Booting SMP configuration:
=5B    0.226881=5D .... node  =230, CPUs:      =231
=5B    0.002792=5D random: get_random_bytes called from start_secondary+0=
x178/0x220 with crng_init=3D0
=5B    0.236854=5D  =232 =233
=5B    0.246791=5D smp: Brought up 1 node, 4 CPUs
=5B    0.246791=5D smpboot: Max logical packages: 1
=5B    0.246791=5D smpboot: Total of 4 processors activated (21531.12 Bog=
oMIPS)
=5B    0.386688=5D node 0 initialised, 3215756 pages in 139ms
=5B    0.386860=5D pgdatinit0 (29) used greatest stack depth: 14672 bytes=
 left
=5B    0.387859=5D devtmpfs: initialized
=5B    0.389105=5D clocksource: jiffies: mask: 0xffffffff max_cycles: 0xf=
fffffff, max_idle_ns: 1911260446275000 ns
=5B    0.389105=5D futex hash table entries: 1024 (order: 5, 131072 bytes=
)
=5B    0.390379=5D NET: Registered protocol family 16
=5B    0.390985=5D audit: initializing netlink subsys (disabled)
=5B    0.391084=5D audit: type=3D2000 audit(1539957692.222:1): state=3Din=
itialized audit_enabled=3D0 res=3D1
=5B    0.391084=5D cpuidle: using governor ladder
=5B    0.391084=5D cpuidle: using governor menu
=5B    0.391753=5D ACPI FADT declares the system doesn't support PCIe ASP=
M, so disable it
=5B    0.391764=5D ACPI: bus type PCI registered
=5B    0.391942=5D PCI: MMCONFIG for domain 0000 =5Bbus 00-3f=5D at =5Bme=
m 0xf8000000-0xfbffffff=5D (base 0xf8000000)
=5B    0.391949=5D PCI: MMCONFIG at =5Bmem 0xf8000000-0xfbffffff=5D reser=
ved in E820
=5B    0.391963=5D pmd_set_huge: Cannot satisfy =5Bmem 0xf8000000-0xf8200=
000=5D with a huge-page mapping due to MTRR override.
=5B    0.392107=5D PCI: Using configuration type 1 for base access
=5B    0.392209=5D core: PMU erratum BJ122, BV98, HSD29 worked around, HT=
 is on
=5B    0.401831=5D HugeTLB registered 2.00 MiB page size, pre-allocated 0=
 pages
=5B    0.402910=5D fbcon: Taking over console
=5B    0.403697=5D ACPI: Added _OSI(Module Device)
=5B    0.403697=5D ACPI: Added _OSI(Processor Device)
=5B    0.403697=5D ACPI: Added _OSI(3.0 _SCP Extensions)
=5B    0.403697=5D ACPI: Added _OSI(Processor Aggregator Device)
=5B    0.403697=5D ACPI: Added _OSI(Linux-Dell-Video)
=5B    0.403697=5D ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
=5B    0.441605=5D ACPI: 6 ACPI AML tables successfully acquired and load=
ed
=5B    0.458487=5D ACPI: =5BFirmware Bug=5D: BIOS _OSI(Linux) query ignor=
ed
=5B    0.465686=5D ACPI: Dynamic OEM Table Load:
=5B    0.465712=5D ACPI: SSDT 0xFFFF9E3A90EEA800 000523 (v01 PmRef  Cpu0C=
st  00003001 INTL 20051117)
=5B    0.467507=5D ACPI: Dynamic OEM Table Load:
=5B    0.467531=5D ACPI: SSDT 0xFFFF9E39476CBC00 000303 (v01 PmRef  ApIst=
    00003000 INTL 20051117)
=5B    0.468611=5D ACPI: Dynamic OEM Table Load:
=5B    0.468635=5D ACPI: SSDT 0xFFFF9E3A90EE9200 000119 (v01 PmRef  ApCst=
    00003000 INTL 20051117)
=5B    0.472860=5D ACPI: EC: EC started
=5B    0.472867=5D ACPI: EC: interrupt blocked
=5B    0.478927=5D ACPI: =5C_SB_.PCI0.LPCB.ECDV: Used as first EC
=5B    0.478934=5D ACPI: =5C_SB_.PCI0.LPCB.ECDV: GPE=3D0x10, EC_CMD/EC_SC=
=3D0x934, EC_DATA=3D0x930
=5B    0.478940=5D ACPI: =5C_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to =
handle transactions
=5B    0.478943=5D ACPI: Interpreter enabled
=5B    0.478963=5D ACPI: (supports S0 S5)
=5B    0.478968=5D ACPI: Using IOAPIC for interrupt routing
=5B    0.479066=5D PCI: Using host bridge windows from ACPI; if necessary=
, use =22pci=3Dnocrs=22 and report a bug
=5B    0.480422=5D ACPI: Enabled 14 GPEs in block 00 to 3F
=5B    0.524862=5D acpi LNXIOBAY:00: ACPI dock station (docks/bays count:=
 1)
=5B    0.549633=5D ACPI: PCI Root Bridge =5BPCI0=5D (domain 0000 =5Bbus 0=
0-3e=5D)
=5B    0.549646=5D acpi PNP0A08:00: _OSC: OS supports =5BExtendedConfig A=
SPM ClockPM Segments MSI=5D
=5B    0.550392=5D acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASP=
M
=5B    0.551966=5D PCI host bridge to bus 0000:00
=5B    0.551972=5D pci_bus 0000:00: root bus resource =5Bio  0x0000-0x0cf=
7 window=5D
=5B    0.551977=5D pci_bus 0000:00: root bus resource =5Bio  0x0d00-0xfff=
f window=5D
=5B    0.551982=5D pci_bus 0000:00: root bus resource =5Bmem 0x000a0000-0=
x000bffff window=5D
=5B    0.551986=5D pci_bus 0000:00: root bus resource =5Bmem 0x000d0000-0=
x000d3fff window=5D
=5B    0.551991=5D pci_bus 0000:00: root bus resource =5Bmem 0x000d4000-0=
x000d7fff window=5D
=5B    0.551995=5D pci_bus 0000:00: root bus resource =5Bmem 0x000d8000-0=
x000dbfff window=5D
=5B    0.552000=5D pci_bus 0000:00: root bus resource =5Bmem 0x000dc000-0=
x000dffff window=5D
=5B    0.552004=5D pci_bus 0000:00: root bus resource =5Bmem 0xd0000000-0=
xfeafffff window=5D
=5B    0.552010=5D pci_bus 0000:00: root bus resource =5Bbus 00-3e=5D
=5B    0.552039=5D pci 0000:00:00.0: =5B8086:0154=5D type 00 class 0x0600=
00
=5B    0.552599=5D pci 0000:00:01.0: =5B8086:0151=5D type 01 class 0x0604=
00
=5B    0.552695=5D pci 0000:00:01.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.553332=5D pci 0000:00:14.0: =5B8086:1e31=5D type 00 class 0x0c03=
30
=5B    0.553385=5D pci 0000:00:14.0: reg 0x10: =5Bmem 0xf7720000-0xf772ff=
ff 64bit=5D
=5B    0.553540=5D pci 0000:00:14.0: PME=23 supported from D3hot D3cold
=5B    0.554066=5D pci 0000:00:16.0: =5B8086:1e3a=5D type 00 class 0x0780=
00
=5B    0.554118=5D pci 0000:00:16.0: reg 0x10: =5Bmem 0xf773c000-0xf773c0=
0f 64bit=5D
=5B    0.554271=5D pci 0000:00:16.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.554786=5D pci 0000:00:19.0: =5B8086:1502=5D type 00 class 0x0200=
00
=5B    0.554838=5D pci 0000:00:19.0: reg 0x10: =5Bmem 0xf7700000-0xf771ff=
ff=5D
=5B    0.554859=5D pci 0000:00:19.0: reg 0x14: =5Bmem 0xf7739000-0xf7739f=
ff=5D
=5B    0.554878=5D pci 0000:00:19.0: reg 0x18: =5Bio  0xf040-0xf05f=5D
=5B    0.555028=5D pci 0000:00:19.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.555537=5D pci 0000:00:1a.0: =5B8086:1e2d=5D type 00 class 0x0c03=
20
=5B    0.555582=5D pci 0000:00:1a.0: reg 0x10: =5Bmem 0xf7738000-0xf77383=
ff=5D
=5B    0.555767=5D pci 0000:00:1a.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.556286=5D pci 0000:00:1b.0: =5B8086:1e20=5D type 00 class 0x0403=
00
=5B    0.556334=5D pci 0000:00:1b.0: reg 0x10: =5Bmem 0xf7730000-0xf7733f=
ff 64bit=5D
=5B    0.556514=5D pci 0000:00:1b.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.557058=5D pci 0000:00:1c.0: =5B8086:1e10=5D type 01 class 0x0604=
00
=5B    0.557254=5D pci 0000:00:1c.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.557300=5D pci 0000:00:1c.0: Enabling MPC IRBNCE
=5B    0.557306=5D pci 0000:00:1c.0: Intel PCH root port ACS workaround e=
nabled
=5B    0.557837=5D pci 0000:00:1c.1: =5B8086:1e12=5D type 01 class 0x0604=
00
=5B    0.558033=5D pci 0000:00:1c.1: PME=23 supported from D0 D3hot D3col=
d
=5B    0.558079=5D pci 0000:00:1c.1: Enabling MPC IRBNCE
=5B    0.558086=5D pci 0000:00:1c.1: Intel PCH root port ACS workaround e=
nabled
=5B    0.558589=5D pci 0000:00:1c.2: =5B8086:1e14=5D type 01 class 0x0604=
00
=5B    0.558789=5D pci 0000:00:1c.2: PME=23 supported from D0 D3hot D3col=
d
=5B    0.558838=5D pci 0000:00:1c.2: Enabling MPC IRBNCE
=5B    0.558845=5D pci 0000:00:1c.2: Intel PCH root port ACS workaround e=
nabled
=5B    0.559355=5D pci 0000:00:1c.3: =5B8086:1e16=5D type 01 class 0x0604=
00
=5B    0.559544=5D pci 0000:00:1c.3: PME=23 supported from D0 D3hot D3col=
d
=5B    0.559588=5D pci 0000:00:1c.3: Enabling MPC IRBNCE
=5B    0.559589=5D pci 0000:00:1c.3: Intel PCH root port ACS workaround e=
nabled
=5B    0.560131=5D pci 0000:00:1c.5: =5B8086:1e1a=5D type 01 class 0x0604=
00
=5B    0.560325=5D pci 0000:00:1c.5: PME=23 supported from D0 D3hot D3col=
d
=5B    0.560370=5D pci 0000:00:1c.5: Enabling MPC IRBNCE
=5B    0.560378=5D pci 0000:00:1c.5: Intel PCH root port ACS workaround e=
nabled
=5B    0.560923=5D pci 0000:00:1d.0: =5B8086:1e26=5D type 00 class 0x0c03=
20
=5B    0.560968=5D pci 0000:00:1d.0: reg 0x10: =5Bmem 0xf7737000-0xf77373=
ff=5D
=5B    0.561145=5D pci 0000:00:1d.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.561655=5D pci 0000:00:1f.0: =5B8086:1e55=5D type 00 class 0x0601=
00
=5B    0.562343=5D pci 0000:00:1f.2: =5B8086:1e03=5D type 00 class 0x0106=
01
=5B    0.562391=5D pci 0000:00:1f.2: reg 0x10: =5Bio  0xf090-0xf097=5D
=5B    0.562410=5D pci 0000:00:1f.2: reg 0x14: =5Bio  0xf080-0xf083=5D
=5B    0.562429=5D pci 0000:00:1f.2: reg 0x18: =5Bio  0xf070-0xf077=5D
=5B    0.562449=5D pci 0000:00:1f.2: reg 0x1c: =5Bio  0xf060-0xf063=5D
=5B    0.562469=5D pci 0000:00:1f.2: reg 0x20: =5Bio  0xf020-0xf03f=5D
=5B    0.562489=5D pci 0000:00:1f.2: reg 0x24: =5Bmem 0xf7736000-0xf77367=
ff=5D
=5B    0.562605=5D pci 0000:00:1f.2: PME=23 supported from D3hot
=5B    0.563127=5D pci 0000:00:1f.3: =5B8086:1e22=5D type 00 class 0x0c05=
00
=5B    0.563171=5D pci 0000:00:1f.3: reg 0x10: =5Bmem 0xf7735000-0xf77350=
ff 64bit=5D
=5B    0.563221=5D pci 0000:00:1f.3: reg 0x20: =5Bio  0xf000-0xf01f=5D
=5B    0.563871=5D pci 0000:01:00.0: =5B10de:0dfc=5D type 00 class 0x0300=
00
=5B    0.563900=5D pci 0000:01:00.0: reg 0x10: =5Bmem 0xf5000000-0xf5ffff=
ff=5D
=5B    0.563918=5D pci 0000:01:00.0: reg 0x14: =5Bmem 0xe0000000-0xefffff=
ff 64bit pref=5D
=5B    0.563935=5D pci 0000:01:00.0: reg 0x1c: =5Bmem 0xf0000000-0xf1ffff=
ff 64bit pref=5D
=5B    0.563948=5D pci 0000:01:00.0: reg 0x24: =5Bio  0xe000-0xe07f=5D
=5B    0.563960=5D pci 0000:01:00.0: reg 0x30: =5Bmem 0xf6000000-0xf607ff=
ff pref=5D
=5B    0.563971=5D pci 0000:01:00.0: enabling Extended Tags
=5B    0.564000=5D pci 0000:01:00.0: BAR 3: assigned to efifb
=5B    0.564081=5D pci 0000:01:00.0: 64.000 Gb/s available PCIe bandwidth=
, limited by 5 GT/s x16 link at 0000:00:01.0 (capable of 126.016 Gb/s wit=
h 8 GT/s x16 link)
=5B    0.564754=5D pci 0000:01:00.1: =5B10de:0bea=5D type 00 class 0x0403=
00
=5B    0.564777=5D pci 0000:01:00.1: reg 0x10: =5Bmem 0xf6080000-0xf6083f=
ff=5D
=5B    0.564831=5D pci 0000:01:00.1: enabling Extended Tags
=5B    0.565063=5D pci 0000:00:01.0: PCI bridge to =5Bbus 01=5D
=5B    0.565069=5D pci 0000:00:01.0:   bridge window =5Bio  0xe000-0xefff=
=5D
=5B    0.565075=5D pci 0000:00:01.0:   bridge window =5Bmem 0xf5000000-0x=
f60fffff=5D
=5B    0.565082=5D pci 0000:00:01.0:   bridge window =5Bmem 0xe0000000-0x=
f1ffffff 64bit pref=5D
=5B    0.565208=5D pci 0000:00:1c.0: PCI bridge to =5Bbus 02=5D
=5B    0.565391=5D pci 0000:03:00.0: =5B14e4:4727=5D type 00 class 0x0280=
00
=5B    0.565454=5D pci 0000:03:00.0: reg 0x10: =5Bmem 0xf7600000-0xf7603f=
ff 64bit=5D
=5B    0.565541=5D pci 0000:03:00.0: enabling Extended Tags
=5B    0.565722=5D pci 0000:03:00.0: supports D1 D2
=5B    0.565726=5D pci 0000:03:00.0: PME=23 supported from D0 D3hot D3col=
d
=5B    0.565790=5D pci 0000:03:00.0: 2.000 Gb/s available PCIe bandwidth,=
 limited by 2.5 GT/s x1 link at 0000:00:1c.1 (capable of 7.876 Gb/s with =
8 GT/s x1 link)
=5B    0.565976=5D pci 0000:00:1c.1: PCI bridge to =5Bbus 03=5D
=5B    0.565989=5D pci 0000:00:1c.1:   bridge window =5Bmem 0xf7600000-0x=
f76fffff=5D
=5B    0.566117=5D pci 0000:00:1c.2: PCI bridge to =5Bbus 04-07=5D
=5B    0.566125=5D pci 0000:00:1c.2:   bridge window =5Bio  0xd000-0xdfff=
=5D
=5B    0.566133=5D pci 0000:00:1c.2:   bridge window =5Bmem 0xf6b00000-0x=
f74fffff=5D
=5B    0.566146=5D pci 0000:00:1c.2:   bridge window =5Bmem 0xf2b00000-0x=
f34fffff 64bit pref=5D
=5B    0.566264=5D pci 0000:00:1c.3: PCI bridge to =5Bbus 08-0b=5D
=5B    0.566272=5D pci 0000:00:1c.3:   bridge window =5Bio  0xc000-0xcfff=
=5D
=5B    0.566280=5D pci 0000:00:1c.3:   bridge window =5Bmem 0xf6100000-0x=
f6afffff=5D
=5B    0.566293=5D pci 0000:00:1c.3:   bridge window =5Bmem 0xf2100000-0x=
f2afffff 64bit pref=5D
=5B    0.566546=5D pci 0000:0c:00.0: =5B1217:8221=5D type 00 class 0x0805=
01
=5B    0.566645=5D pci 0000:0c:00.0: reg 0x10: =5Bmem 0xf7500000-0xf75001=
ff=5D
=5B    0.567111=5D pci 0000:0c:00.0: supports D1 D2
=5B    0.567115=5D pci 0000:0c:00.0: PME=23 supported from D0 D1 D2 D3hot=
 D3cold
=5B    0.567213=5D pci 0000:0c:00.0: 2.000 Gb/s available PCIe bandwidth,=
 limited by 2.5 GT/s x1 link at 0000:00:1c.5 (capable of 7.876 Gb/s with =
8 GT/s x1 link)
=5B    0.567406=5D pci 0000:00:1c.5: PCI bridge to =5Bbus 0c=5D
=5B    0.567419=5D pci 0000:00:1c.5:   bridge window =5Bmem 0xf7500000-0x=
f75fffff=5D
=5B    0.567497=5D pci_bus 0000:00: on NUMA node 0
=5B    0.574444=5D ACPI: PCI Interrupt Link =5BLNKA=5D (IRQs 3 4 5 6 10 *=
11 12 14 15)
=5B    0.574755=5D ACPI: PCI Interrupt Link =5BLNKB=5D (IRQs 3 4 5 6 *10 =
11 12 14 15)
=5B    0.575041=5D ACPI: PCI Interrupt Link =5BLNKC=5D (IRQs 3 4 5 6 *10 =
11 12 14 15)
=5B    0.575328=5D ACPI: PCI Interrupt Link =5BLNKD=5D (IRQs 3 4 *5 6 10 =
11 12 14 15)
=5B    0.575617=5D ACPI: PCI Interrupt Link =5BLNKE=5D (IRQs *3 4 5 6 10 =
11 12 14 15)
=5B    0.575910=5D ACPI: PCI Interrupt Link =5BLNKF=5D (IRQs 3 4 *5 6 10 =
11 12 14 15)
=5B    0.576197=5D ACPI: PCI Interrupt Link =5BLNKG=5D (IRQs 3 4 5 6 10 *=
11 12 14 15)
=5B    0.576482=5D ACPI: PCI Interrupt Link =5BLNKH=5D (IRQs 3 4 5 6 10 1=
1 12 14 15) *0, disabled.
=5B    0.585257=5D ACPI: EC: interrupt unblocked
=5B    0.585291=5D ACPI: EC: event unblocked
=5B    0.585308=5D ACPI: =5C_SB_.PCI0.LPCB.ECDV: GPE=3D0x10, EC_CMD/EC_SC=
=3D0x934, EC_DATA=3D0x930
=5B    0.585316=5D ACPI: =5C_SB_.PCI0.LPCB.ECDV: Used as boot DSDT EC to =
handle transactions and events
=5B    0.585908=5D pci 0000:01:00.0: vgaarb: setting as boot VGA device
=5B    0.585908=5D pci 0000:01:00.0: vgaarb: VGA device added: decodes=3D=
io+mem,owns=3Dio+mem,locks=3Dnone
=5B    0.585908=5D pci 0000:01:00.0: vgaarb: bridge control possible
=5B    0.585908=5D vgaarb: loaded
=5B    0.586705=5D SCSI subsystem initialized
=5B    0.586747=5D libata version 3.00 loaded.
=5B    0.586780=5D ACPI: bus type USB registered
=5B    0.586859=5D usbcore: registered new interface driver usbfs
=5B    0.586905=5D usbcore: registered new interface driver hub
=5B    0.587002=5D usbcore: registered new device driver usb
=5B    0.587065=5D videodev: Linux video capture interface: v2.00
=5B    0.587088=5D pps_core: LinuxPPS API ver. 1 registered
=5B    0.587091=5D pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Ro=
dolfo Giometti <giometti=40linux.it>
=5B    0.587105=5D PTP clock support registered
=5B    0.587265=5D Registered efivars operations
=5B    0.597743=5D Advanced Linux Sound Architecture Driver Initialized.
=5B    0.597818=5D PCI: Using ACPI for IRQ routing
=5B    0.602339=5D PCI: pci_cache_line_size set to 64 bytes
=5B    0.602566=5D e820: reserve RAM buffer =5Bmem 0x0009f000-0x0009ffff=
=5D
=5B    0.602573=5D e820: reserve RAM buffer =5Bmem 0xc7a8a018-0xc7ffffff=
=5D
=5B    0.602578=5D e820: reserve RAM buffer =5Bmem 0xc7a9a018-0xc7ffffff=
=5D
=5B    0.602583=5D e820: reserve RAM buffer =5Bmem 0xca70a000-0xcbffffff=
=5D
=5B    0.602587=5D e820: reserve RAM buffer =5Bmem 0xcaf53000-0xcbffffff=
=5D
=5B    0.602589=5D e820: reserve RAM buffer =5Bmem 0xcb7b2000-0xcbffffff=
=5D
=5B    0.602600=5D e820: reserve RAM buffer =5Bmem 0xccefe000-0xcfffffff=
=5D
=5B    0.602604=5D e820: reserve RAM buffer =5Bmem 0xce59c000-0xcfffffff=
=5D
=5B    0.602609=5D e820: reserve RAM buffer =5Bmem 0xcf2b1000-0xcfffffff=
=5D
=5B    0.602614=5D e820: reserve RAM buffer =5Bmem 0xcf800000-0xcfffffff=
=5D
=5B    0.602619=5D e820: reserve RAM buffer =5Bmem 0x40dfad000-0x40ffffff=
f=5D
=5B    0.602624=5D e820: reserve RAM buffer =5Bmem 0x40dfaf000-0x40ffffff=
f=5D
=5B    0.602629=5D e820: reserve RAM buffer =5Bmem 0x40dfeb000-0x40ffffff=
f=5D
=5B    0.602633=5D e820: reserve RAM buffer =5Bmem 0x42e000000-0x42ffffff=
f=5D
=5B    0.603215=5D NetLabel: Initializing
=5B    0.603219=5D NetLabel:  domain hash size =3D 128
=5B    0.603222=5D NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
=5B    0.603277=5D NetLabel:  unlabeled traffic allowed by default
=5B    0.603673=5D dcdbas dcdbas: Dell Systems Management Base Driver (ve=
rsion 5.6.0-3.3)
=5B    0.603971=5D wmi_bus wmi_bus-PNP0C14:00: WQBC data block query cont=
rol method not found
=5B    0.604371=5D hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0=

=5B    0.604383=5D hpet0: 8 comparators, 64-bit 14.318180 MHz counter
=5B    0.605673=5D clocksource: Switched to clocksource tsc-early
=5B    0.690896=5D Warning: could not register annotated branches stats
=5B    0.691272=5D VFS: Disk quotas dquot_6.6.0
=5B    0.691319=5D VFS: Dquot-cache hash table entries: 512 (order 0, 409=
6 bytes)
=5B    0.691422=5D *** VALIDATE hugetlbfs ***
=5B    0.691562=5D pnp: PnP ACPI init
=5B    0.692050=5D system 00:00: =5Bio  0x0680-0x069f=5D has been reserve=
d
=5B    0.692057=5D system 00:00: =5Bio  0x1000-0x100f=5D has been reserve=
d
=5B    0.692065=5D system 00:00: =5Bio  0x1100-0x1103=5D has been reserve=
d
=5B    0.692071=5D system 00:00: =5Bio  0xffff=5D has been reserved
=5B    0.692077=5D system 00:00: =5Bio  0x0400-0x0453=5D has been reserve=
d
=5B    0.692083=5D system 00:00: =5Bio  0x0458-0x047f=5D has been reserve=
d
=5B    0.692091=5D system 00:00: =5Bio  0x0500-0x057f=5D has been reserve=
d
=5B    0.692097=5D system 00:00: =5Bio  0x164e-0x164f=5D has been reserve=
d
=5B    0.692122=5D system 00:00: Plug and Play ACPI device, IDs PNP0c02 (=
active)
=5B    0.692225=5D pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (act=
ive)
=5B    0.692434=5D system 00:02: =5Bio  0x0454-0x0457=5D has been reserve=
d
=5B    0.692449=5D system 00:02: Plug and Play ACPI device, IDs INT3f0d P=
NP0c02 (active)
=5B    0.692677=5D system 00:03: =5Bio  0x04d0-0x04d1=5D has been reserve=
d
=5B    0.692692=5D system 00:03: Plug and Play ACPI device, IDs PNP0c02 (=
active)
=5B    0.692856=5D pnp 00:04: Plug and Play ACPI device, IDs PNP0303 (act=
ive)
=5B    0.692951=5D pnp 00:05: Plug and Play ACPI device, IDs DLL0535 PNP0=
f13 (active)
=5B    0.695944=5D pnp 00:06: Plug and Play ACPI device, IDs PNP0401 (dis=
abled)
=5B    0.698387=5D system 00:07: =5Bmem 0xfed1c000-0xfed1ffff=5D has been=
 reserved
=5B    0.698394=5D system 00:07: =5Bmem 0xfed10000-0xfed17fff=5D has been=
 reserved
=5B    0.698400=5D system 00:07: =5Bmem 0xfed18000-0xfed18fff=5D has been=
 reserved
=5B    0.698407=5D system 00:07: =5Bmem 0xfed19000-0xfed19fff=5D has been=
 reserved
=5B    0.698413=5D system 00:07: =5Bmem 0xf8000000-0xfbffffff=5D has been=
 reserved
=5B    0.698419=5D system 00:07: =5Bmem 0xfed20000-0xfed3ffff=5D has been=
 reserved
=5B    0.698426=5D system 00:07: =5Bmem 0xfed90000-0xfed93fff=5D could no=
t be reserved
=5B    0.698432=5D system 00:07: =5Bmem 0xfed45000-0xfed8ffff=5D has been=
 reserved
=5B    0.698438=5D system 00:07: =5Bmem 0xff000000-0xffffffff=5D has been=
 reserved
=5B    0.698445=5D system 00:07: =5Bmem 0xfee00000-0xfeefffff=5D could no=
t be reserved
=5B    0.698451=5D system 00:07: =5Bmem 0xd0000000-0xd0000fff=5D has been=
 reserved
=5B    0.698465=5D system 00:07: Plug and Play ACPI device, IDs PNP0c02 (=
active)
=5B    0.707798=5D pnp 00:08: Plug and Play ACPI device, IDs PNP0c31 (act=
ive)
=5B    0.707821=5D pnp: PnP ACPI: found 9 devices
=5B    0.720225=5D clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xfff=
fff, max_idle_ns: 2085701024 ns
=5B    0.720319=5D pci 0000:00:01.0: PCI bridge to =5Bbus 01=5D
=5B    0.720325=5D pci 0000:00:01.0:   bridge window =5Bio  0xe000-0xefff=
=5D
=5B    0.720331=5D pci 0000:00:01.0:   bridge window =5Bmem 0xf5000000-0x=
f60fffff=5D
=5B    0.720337=5D pci 0000:00:01.0:   bridge window =5Bmem 0xe0000000-0x=
f1ffffff 64bit pref=5D
=5B    0.720344=5D pci 0000:00:1c.0: PCI bridge to =5Bbus 02=5D
=5B    0.720371=5D pci 0000:00:1c.1: PCI bridge to =5Bbus 03=5D
=5B    0.720381=5D pci 0000:00:1c.1:   bridge window =5Bmem 0xf7600000-0x=
f76fffff=5D
=5B    0.720400=5D pci 0000:00:1c.2: PCI bridge to =5Bbus 04-07=5D
=5B    0.720406=5D pci 0000:00:1c.2:   bridge window =5Bio  0xd000-0xdfff=
=5D
=5B    0.720416=5D pci 0000:00:1c.2:   bridge window =5Bmem 0xf6b00000-0x=
f74fffff=5D
=5B    0.720423=5D pci 0000:00:1c.2:   bridge window =5Bmem 0xf2b00000-0x=
f34fffff 64bit pref=5D
=5B    0.720437=5D pci 0000:00:1c.3: PCI bridge to =5Bbus 08-0b=5D
=5B    0.720444=5D pci 0000:00:1c.3:   bridge window =5Bio  0xc000-0xcfff=
=5D
=5B    0.720454=5D pci 0000:00:1c.3:   bridge window =5Bmem 0xf6100000-0x=
f6afffff=5D
=5B    0.720463=5D pci 0000:00:1c.3:   bridge window =5Bmem 0xf2100000-0x=
f2afffff 64bit pref=5D
=5B    0.720476=5D pci 0000:00:1c.5: PCI bridge to =5Bbus 0c=5D
=5B    0.720488=5D pci 0000:00:1c.5:   bridge window =5Bmem 0xf7500000-0x=
f75fffff=5D
=5B    0.720507=5D pci_bus 0000:00: resource 4 =5Bio  0x0000-0x0cf7 windo=
w=5D
=5B    0.720511=5D pci_bus 0000:00: resource 5 =5Bio  0x0d00-0xffff windo=
w=5D
=5B    0.720515=5D pci_bus 0000:00: resource 6 =5Bmem 0x000a0000-0x000bff=
ff window=5D
=5B    0.720519=5D pci_bus 0000:00: resource 7 =5Bmem 0x000d0000-0x000d3f=
ff window=5D
=5B    0.720523=5D pci_bus 0000:00: resource 8 =5Bmem 0x000d4000-0x000d7f=
ff window=5D
=5B    0.720527=5D pci_bus 0000:00: resource 9 =5Bmem 0x000d8000-0x000dbf=
ff window=5D
=5B    0.720531=5D pci_bus 0000:00: resource 10 =5Bmem 0x000dc000-0x000df=
fff window=5D
=5B    0.720535=5D pci_bus 0000:00: resource 11 =5Bmem 0xd0000000-0xfeaff=
fff window=5D
=5B    0.720538=5D pci_bus 0000:01: resource 0 =5Bio  0xe000-0xefff=5D
=5B    0.720542=5D pci_bus 0000:01: resource 1 =5Bmem 0xf5000000-0xf60fff=
ff=5D
=5B    0.720546=5D pci_bus 0000:01: resource 2 =5Bmem 0xe0000000-0xf1ffff=
ff 64bit pref=5D
=5B    0.720550=5D pci_bus 0000:03: resource 1 =5Bmem 0xf7600000-0xf76fff=
ff=5D
=5B    0.720554=5D pci_bus 0000:04: resource 0 =5Bio  0xd000-0xdfff=5D
=5B    0.720558=5D pci_bus 0000:04: resource 1 =5Bmem 0xf6b00000-0xf74fff=
ff=5D
=5B    0.720562=5D pci_bus 0000:04: resource 2 =5Bmem 0xf2b00000-0xf34fff=
ff 64bit pref=5D
=5B    0.720566=5D pci_bus 0000:08: resource 0 =5Bio  0xc000-0xcfff=5D
=5B    0.720569=5D pci_bus 0000:08: resource 1 =5Bmem 0xf6100000-0xf6afff=
ff=5D
=5B    0.720573=5D pci_bus 0000:08: resource 2 =5Bmem 0xf2100000-0xf2afff=
ff 64bit pref=5D
=5B    0.720577=5D pci_bus 0000:0c: resource 1 =5Bmem 0xf7500000-0xf75fff=
ff=5D
=5B    0.721259=5D NET: Registered protocol family 2
=5B    0.721863=5D tcp_listen_portaddr_hash hash table entries: 8192 (ord=
er: 7, 720896 bytes)
=5B    0.722155=5D TCP established hash table entries: 131072 (order: 8, =
1048576 bytes)
=5B    0.722504=5D TCP bind hash table entries: 32768 (order: 9, 2621440 =
bytes)
=5B    0.723553=5D TCP: Hash tables configured (established 131072 bind 3=
2768)
=5B    0.723790=5D UDP hash table entries: 8192 (order: 8, 1572864 bytes)=

=5B    0.724373=5D UDP-Lite hash table entries: 8192 (order: 8, 1572864 b=
ytes)
=5B    0.725084=5D NET: Registered protocol family 1
=5B    0.725452=5D NET: Registered protocol family 44
=5B    0.753226=5D pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x6dd to=
ok 17290 usecs
=5B    0.771219=5D pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x6dd to=
ok 17528 usecs
=5B    0.771260=5D pci 0000:01:00.0: Video device with shadowed ROM at =
=5Bmem 0x000c0000-0x000dffff=5D
=5B    0.771304=5D pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0=

=5B    0.771433=5D PCI: CLS mismatch (64 =21=3D 32), using 64 bytes
=5B    0.771804=5D Unpacking initramfs...
=5B    2.259557=5D Freeing initrd memory: 13080K
=5B    2.259702=5D DMAR: No ATSR found
=5B    2.259881=5D DMAR: dmar0: Using Queued invalidation
=5B    2.259924=5D DMAR: Setting RMRR:
=5B    2.260160=5D DMAR: Setting identity map for device 0000:00:14.0 =5B=
0xce712000 - 0xce731fff=5D
=5B    2.260337=5D DMAR: Setting identity map for device 0000:00:1a.0 =5B=
0xce712000 - 0xce731fff=5D
=5B    2.260480=5D DMAR: Setting identity map for device 0000:00:1d.0 =5B=
0xce712000 - 0xce731fff=5D
=5B    2.260500=5D DMAR: Prepare 0-16MiB unity mapping for LPC
=5B    2.260695=5D DMAR: Setting identity map for device 0000:00:1f.0 =5B=
0x0 - 0xffffff=5D
=5B    2.260810=5D DMAR: Intel(R) Virtualization Technology for Directed =
I/O
=5B    2.260995=5D iommu: Adding device 0000:00:00.0 to group 0
=5B    2.261077=5D iommu: Adding device 0000:00:01.0 to group 1
=5B    2.261133=5D iommu: Adding device 0000:00:14.0 to group 2
=5B    2.261208=5D iommu: Adding device 0000:00:16.0 to group 3
=5B    2.261262=5D iommu: Adding device 0000:00:19.0 to group 4
=5B    2.261320=5D iommu: Adding device 0000:00:1a.0 to group 5
=5B    2.261377=5D iommu: Adding device 0000:00:1b.0 to group 6
=5B    2.261432=5D iommu: Adding device 0000:00:1c.0 to group 7
=5B    2.261488=5D iommu: Adding device 0000:00:1c.1 to group 8
=5B    2.261543=5D iommu: Adding device 0000:00:1c.2 to group 9
=5B    2.261616=5D iommu: Adding device 0000:00:1c.3 to group 10
=5B    2.261674=5D iommu: Adding device 0000:00:1c.5 to group 11
=5B    2.261728=5D iommu: Adding device 0000:00:1d.0 to group 12
=5B    2.261843=5D iommu: Adding device 0000:00:1f.0 to group 13
=5B    2.261899=5D iommu: Adding device 0000:00:1f.2 to group 13
=5B    2.261952=5D iommu: Adding device 0000:00:1f.3 to group 13
=5B    2.261975=5D iommu: Adding device 0000:01:00.0 to group 1
=5B    2.261997=5D iommu: Adding device 0000:01:00.1 to group 1
=5B    2.262055=5D iommu: Adding device 0000:03:00.0 to group 14
=5B    2.262110=5D iommu: Adding device 0000:0c:00.0 to group 15
=5B    2.276371=5D RAPL PMU: API unit is 2=5E-32 Joules, 3 fixed counters=
, 163840 ms ovfl timer
=5B    2.276375=5D RAPL PMU: hw unit of domain pp0-core 2=5E-16 Joules
=5B    2.276378=5D RAPL PMU: hw unit of domain package 2=5E-16 Joules
=5B    2.276381=5D RAPL PMU: hw unit of domain pp1-gpu 2=5E-16 Joules
=5B    2.279367=5D _warn_unseeded_randomness: 6 callbacks suppressed
=5B    2.279373=5D random: get_random_bytes called from create_elf_tables=
+0xd1/0x9e0 with crng_init=3D0
=5B    2.281754=5D modprobe (50) used greatest stack depth: 8 bytes left
=5B    2.283784=5D Initialise system trusted keyrings
=5B    2.283808=5D random: get_random_bytes called from key_alloc+0x261/0=
x480 with crng_init=3D0
=5B    2.283991=5D workingset: timestamp_bits=3D47 max_order=3D22 bucket_=
order=3D0
=5B    2.284252=5D zbud: loaded
=5B    2.285260=5D pstore: using deflate compression
=5B    2.287134=5D random: get_random_bytes called from create_elf_tables=
+0xd1/0x9e0 with crng_init=3D0
=5B    2.418346=5D Key type asymmetric registered
=5B    2.418366=5D Asymmetric key parser 'x509' registered
=5B    2.418392=5D io scheduler noop registered
=5B    2.418398=5D io scheduler deadline registered
=5B    2.418432=5D io scheduler cfq registered (default)
=5B    2.418589=5D atomic64_test: passed for x86-64 platform with CX8 and=
 with SSE
=5B    2.423165=5D efifb: probing for efifb
=5B    2.423222=5D efifb: framebuffer at 0xf1000000, using 9000k, total 9=
000k
=5B    2.423225=5D efifb: mode is 1920x1200x32, linelength=3D7680, pages=
=3D1
=5B    2.423228=5D efifb: scrolling: redraw
=5B    2.423232=5D efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
=5B    2.423748=5D Console: switching to colour frame buffer device 240x7=
5
=5B    2.429379=5D fb0: EFI VGA frame buffer device
=5B    2.429410=5D intel_idle: MWAIT substates: 0x21120
=5B    2.429414=5D intel_idle: v0.4.1 model 0x3A
=5B    2.430309=5D intel_idle: lapic_timer_reliable_states 0xffffffff
=5B    2.432534=5D ACPI: AC Adapter =5BAC=5D (on-line)
=5B    2.432853=5D input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/=
PNP0C0D:00/input/input0
=5B    2.432861=5D ACPI: Lid Switch =5BLID0=5D
=5B    2.432997=5D input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:0=
0/PNP0C0C:00/input/input1
=5B    2.433020=5D ACPI: Power Button =5BPBTN=5D
=5B    2.433153=5D input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:0=
0/PNP0C0E:00/input/input2
=5B    2.433161=5D ACPI: Sleep Button =5BSBTN=5D
=5B    2.433295=5D input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:0=
0/input/input3
=5B    2.433302=5D ACPI: Power Button =5BPWRF=5D
=5B    2.437875=5D ACPI: Video Device =5BVID=5D (multi-head: yes  rom: ye=
s  post: no)
=5B    2.451855=5D acpi device:17: registered as cooling_device0
=5B    2.452879=5D input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/P=
NP0A08:00/device:14/LNXVIDEO:00/input/input4
=5B    2.456772=5D thermal LNXTHERM:00: registered as thermal_zone0
=5B    2.456776=5D ACPI: Thermal Zone =5BTHM=5D (60 C)
=5B    2.457537=5D Serial: 8250/16550 driver, 4 ports, IRQ sharing enable=
d
=5B    2.461016=5D Hangcheck: starting hangcheck timer 0.9.1 (tick is 180=
 seconds, margin is 60 seconds).
=5B    2.462663=5D tpm_tis 00:08: 1.2 TPM (device-id 0x3204, rev-id 64)
=5B    2.509541=5D loop: module loaded
=5B    2.510640=5D zram: Added device: zram0
=5B    2.512735=5D ahci 0000:00:1f.2: version 3.0
=5B    2.515829=5D ahci 0000:00:1f.2: SSS flag set, parallel bus scan dis=
abled
=5B    2.515876=5D ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 G=
bps 0x33 impl SATA mode
=5B    2.515883=5D ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pi=
o slum part ems sxs apst=20
=5B    2.536313=5D battery: ACPI: Battery Slot =5BBAT0=5D (battery presen=
t)
=5B    2.541779=5D battery: ACPI: Battery Slot =5BBAT1=5D (battery absent=
)
=5B    2.547900=5D battery: ACPI: Battery Slot =5BBAT2=5D (battery absent=
)
=5B    2.549761=5D scsi host0: ahci
=5B    2.550280=5D scsi host1: ahci
=5B    2.550756=5D scsi host2: ahci
=5B    2.551183=5D scsi host3: ahci
=5B    2.551680=5D scsi host4: ahci
=5B    2.552119=5D scsi host5: ahci
=5B    2.552312=5D ata1: SATA max UDMA/133 abar m2048=400xf7736000 port 0=
xf7736100 irq 26
=5B    2.552317=5D ata2: SATA max UDMA/133 abar m2048=400xf7736000 port 0=
xf7736180 irq 26
=5B    2.552320=5D ata3: DUMMY
=5B    2.552324=5D ata4: DUMMY
=5B    2.552331=5D ata5: SATA max UDMA/133 abar m2048=400xf7736000 port 0=
xf7736300 irq 26
=5B    2.552336=5D ata6: SATA max UDMA/133 abar m2048=400xf7736000 port 0=
xf7736380 irq 26
=5B    2.553172=5D e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
=5B    2.553177=5D e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
=5B    2.553983=5D e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/s=
ec) set to dynamic conservative mode
=5B    2.693051=5D e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): regi=
stered PHC clock
=5B    2.813563=5D e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x=
1) f0:1f:af:0c:8a:da
=5B    2.813630=5D e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Co=
nnection
=5B    2.813673=5D e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 70=
11FF-0FF
=5B    2.813759=5D PPP generic driver version 2.4.2
=5B    2.814281=5D ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Dr=
iver
=5B    2.814288=5D ehci-pci: EHCI PCI platform driver
=5B    2.815054=5D ehci-pci 0000:00:1a.0: EHCI Host Controller
=5B    2.815469=5D ehci-pci 0000:00:1a.0: new USB bus registered, assigne=
d bus number 1
=5B    2.815518=5D ehci-pci 0000:00:1a.0: debug port 2
=5B    2.819518=5D ehci-pci 0000:00:1a.0: cache line size of 64 is not su=
pported
=5B    2.819622=5D ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7738000
=5B    2.826734=5D ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
=5B    2.827152=5D usb usb1: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002, bcdDevice=3D 4.19
=5B    2.827163=5D usb usb1: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
=5B    2.827167=5D usb usb1: Product: EHCI Host Controller
=5B    2.827171=5D usb usb1: Manufacturer: Linux 4.19.0-rc8-next-20181016=
-dirty ehci_hcd
=5B    2.827175=5D usb usb1: SerialNumber: 0000:00:1a.0
=5B    2.828016=5D hub 1-0:1.0: USB hub found
=5B    2.828069=5D hub 1-0:1.0: 2 ports detected
=5B    2.829651=5D ehci-pci 0000:00:1d.0: EHCI Host Controller
=5B    2.829878=5D ehci-pci 0000:00:1d.0: new USB bus registered, assigne=
d bus number 2
=5B    2.829905=5D ehci-pci 0000:00:1d.0: debug port 2
=5B    2.833861=5D ehci-pci 0000:00:1d.0: cache line size of 64 is not su=
pported
=5B    2.833915=5D ehci-pci 0000:00:1d.0: irq 21, io mem 0xf7737000
=5B    2.840738=5D ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
=5B    2.841011=5D usb usb2: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002, bcdDevice=3D 4.19
=5B    2.841019=5D usb usb2: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
=5B    2.841023=5D usb usb2: Product: EHCI Host Controller
=5B    2.841027=5D usb usb2: Manufacturer: Linux 4.19.0-rc8-next-20181016=
-dirty ehci_hcd
=5B    2.841032=5D usb usb2: SerialNumber: 0000:00:1d.0
=5B    2.841752=5D hub 2-0:1.0: USB hub found
=5B    2.841794=5D hub 2-0:1.0: 2 ports detected
=5B    2.842495=5D ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver=

=5B    2.842525=5D ohci-pci: OHCI PCI platform driver
=5B    2.842576=5D uhci_hcd: USB Universal Host Controller Interface driv=
er
=5B    2.843337=5D xhci_hcd 0000:00:14.0: xHCI Host Controller
=5B    2.843633=5D xhci_hcd 0000:00:14.0: new USB bus registered, assigne=
d bus number 3
=5B    2.844824=5D xhci_hcd 0000:00:14.0: hcc params 0x20007181 hci versi=
on 0x100 quirks 0x000000000000b930
=5B    2.844838=5D xhci_hcd 0000:00:14.0: cache line size of 64 is not su=
pported
=5B    2.845790=5D usb usb3: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0002, bcdDevice=3D 4.19
=5B    2.845795=5D usb usb3: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
=5B    2.845799=5D usb usb3: Product: xHCI Host Controller
=5B    2.845803=5D usb usb3: Manufacturer: Linux 4.19.0-rc8-next-20181016=
-dirty xhci-hcd
=5B    2.845807=5D usb usb3: SerialNumber: 0000:00:14.0
=5B    2.846316=5D hub 3-0:1.0: USB hub found
=5B    2.846384=5D hub 3-0:1.0: 4 ports detected
=5B    2.848316=5D xhci_hcd 0000:00:14.0: xHCI Host Controller
=5B    2.848634=5D xhci_hcd 0000:00:14.0: new USB bus registered, assigne=
d bus number 4
=5B    2.848646=5D xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpe=
ed
=5B    2.848879=5D usb usb4: New USB device found, idVendor=3D1d6b, idPro=
duct=3D0003, bcdDevice=3D 4.19
=5B    2.848885=5D usb usb4: New USB device strings: Mfr=3D3, Product=3D2=
, SerialNumber=3D1
=5B    2.848889=5D usb usb4: Product: xHCI Host Controller
=5B    2.848893=5D usb usb4: Manufacturer: Linux 4.19.0-rc8-next-20181016=
-dirty xhci-hcd
=5B    2.848897=5D usb usb4: SerialNumber: 0000:00:14.0
=5B    2.849493=5D hub 4-0:1.0: USB hub found
=5B    2.849550=5D hub 4-0:1.0: 4 ports detected
=5B    2.851682=5D usbcore: registered new interface driver usb-storage
=5B    2.851774=5D i8042: PNP: PS/2 Controller =5BPNP0303:PS2K,PNP0f13:PS=
2M=5D at 0x60,0x64 irq 1,12
=5B    2.852320=5D i8042: Warning: Keylock active
=5B    2.855957=5D serio: i8042 KBD port at 0x60,0x64 irq 1
=5B    2.856176=5D serio: i8042 AUX port at 0x60,0x64 irq 12
=5B    2.856516=5D mousedev: PS/2 mouse device common for all mice
=5B    2.857987=5D rtc_cmos 00:01: RTC can wake from S4
=5B    2.858366=5D rtc_cmos 00:01: registered as rtc0
=5B    2.858486=5D rtc_cmos 00:01: alarms up to one month, y3k, 242 bytes=
 nvram, hpet irqs
=5B    2.858541=5D i2c /dev entries driver
=5B    2.859158=5D input: AT Translated Set 2 keyboard as /devices/platfo=
rm/i8042/serio0/input/input5
=5B    2.860221=5D i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
=5B    2.863101=5D ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)=

=5B    2.867342=5D ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) =
succeeded
=5B    2.867355=5D ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZ=
E LOCK) filtered out
=5B    2.867365=5D ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGU=
RATION OVERLAY) filtered out
=5B    2.867761=5D ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected =
by device (Stat=3D0x51 Err=3D0x04)
=5B    2.872850=5D ata1.00: ATA-8: ST500LX003-1AC15G, DEM4, max UDMA/133
=5B    2.872858=5D ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth=
 32)
=5B    2.882631=5D ata1.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) =
succeeded
=5B    2.882639=5D ata1.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZ=
E LOCK) filtered out
=5B    2.882646=5D ata1.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE CONFIGU=
RATION OVERLAY) filtered out
=5B    2.882999=5D ata1.00: ACPI cmd 00/00:00:00:00:00:a0 (NOP) rejected =
by device (Stat=3D0x51 Err=3D0x04)
=5B    2.885351=5D ata1.00: configured for UDMA/133
=5B    2.886809=5D dennis zhou
=5B    2.887146=5D scsi 0:0:0:0: Direct-Access     ATA      ST500LX003-1A=
C15 DEM4 PQ: 0 ANSI: 5
=5B    2.889016=5D sd 0:0:0:0: =5Bsda=5D 976773168 512-byte logical block=
s: (500 GB/466 GiB)
=5B    2.889032=5D sd 0:0:0:0: =5Bsda=5D 4096-byte physical blocks
=5B    2.889134=5D sd 0:0:0:0: =5Bsda=5D Write Protect is off
=5B    2.889141=5D sd 0:0:0:0: =5Bsda=5D Mode Sense: 00 3a 00 00
=5B    2.889312=5D sd 0:0:0:0: =5Bsda=5D Write cache: enabled, read cache=
: enabled, doesn't support DPO or FUA
=5B    2.895403=5D usbcore: registered new interface driver uvcvideo
=5B    2.895409=5D USB Video Class driver (1.1.1)
=5B    2.897342=5D  sda: sda1 sda2 sda3
=5B    2.899459=5D sd 0:0:0:0: =5Bsda=5D Attached SCSI disk
=5B    2.899569=5D iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
=5B    2.899677=5D iTCO_wdt: Found a Panther Point TCO device (Version=3D=
2, TCOBASE=3D0x0460)
=5B    2.900126=5D iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D=
0)
=5B    2.900157=5D iTCO_vendor_support: vendor-support=3D0
=5B    2.900188=5D device-mapper: uevent: version 1.0.3
=5B    2.900384=5D device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initia=
lised: dm-devel=40redhat.com
=5B    2.900403=5D intel_pstate: Intel P-state driver initializing
=5B    2.901073=5D sdhci: Secure Digital Host Controller Interface driver=

=5B    2.901080=5D sdhci: Copyright(c) Pierre Ossman
=5B    2.901195=5D sdhci-pci 0000:0c:00.0: SDHCI controller found =5B1217=
:8221=5D (rev 5)
=5B    2.902398=5D mmc0 bounce up to 128 segments into one, max segment s=
ize 65536 bytes
=5B    2.904036=5D mmc0: SDHCI controller on PCI =5B0000:0c:00.0=5D using=
 DMA
=5B    2.904456=5D sdhci-pltfm: SDHCI platform and OF driver helper
=5B    2.904488=5D EFI Variables Facility v0.08 2004-May-17
=5B    2.925204=5D pstore: Registered efi as persistent store backend
=5B    2.925251=5D hidraw: raw HID events driver (C) Jiri Kosina
=5B    2.925351=5D usbcore: registered new interface driver usbhid
=5B    2.925354=5D usbhid: USB HID core driver
=5B    2.928122=5D snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0=
002)
=5B    2.928302=5D snd_hda_intel 0000:01:00.1: Disabling MSI
=5B    2.929982=5D Initializing XFRM netlink socket
=5B    2.930135=5D NET: Registered protocol family 10
=5B    2.931380=5D Segment Routing with IPv6
=5B    2.931720=5D NET: Registered protocol family 17
=5B    2.931800=5D NET: Registered protocol family 15
=5B    2.932246=5D sctp: Hash tables configured (bind 32/51)
=5B    2.932568=5D Key type dns_resolver registered
=5B    2.932581=5D start plist test
=5B    2.937258=5D snd_hda_codec_idt hdaudioC0D0: autoconfig for 92HD93BX=
X: line_outs=3D1 (0xe/0x0/0x0/0x0/0x0) type:line
=5B    2.937265=5D snd_hda_codec_idt hdaudioC0D0:    speaker_outs=3D1 (0x=
d/0x0/0x0/0x0/0x0)
=5B    2.937268=5D snd_hda_codec_idt hdaudioC0D0:    hp_outs=3D1 (0xb/0x0=
/0x0/0x0/0x0)
=5B    2.937272=5D snd_hda_codec_idt hdaudioC0D0:    mono: mono_out=3D0x0=

=5B    2.937275=5D snd_hda_codec_idt hdaudioC0D0:    inputs:
=5B    2.937278=5D snd_hda_codec_idt hdaudioC0D0:      Dock Mic=3D0xf
=5B    2.937282=5D snd_hda_codec_idt hdaudioC0D0:      Internal Mic=3D0x1=
1
=5B    2.937285=5D snd_hda_codec_idt hdaudioC0D0:      Headset Mic=3D0xa
=5B    2.937983=5D random: fast init done
=5B    2.938929=5D end plist test
=5B    2.940007=5D microcode: sig=3D0x306a9, pf=3D0x10, revision=3D0x20
=5B    2.940267=5D microcode: Microcode Update Driver: v2.2.
=5B    2.940370=5D sched_clock: Marking stable (2938446773, 1792880)->(29=
57124626, -16884973)
=5B    2.941452=5D registered taskstats version 1
=5B    2.941501=5D Loading compiled-in X.509 certificates
=5B    2.946421=5D Loaded X.509 cert 'Magrathea: Glacier signing key: bb7=
2777f81e5af93500bb2beebab944a32df62b5'
=5B    2.946557=5D zswap: loaded using pool lzo/zbud
=5B    2.968266=5D input: HDA Intel PCH Dock Mic as /devices/pci0000:00/0=
000:00:1b.0/sound/card0/input8
=5B    2.968545=5D input: HDA Intel PCH Headset Mic as /devices/pci0000:0=
0/0000:00:1b.0/sound/card0/input9
=5B    2.968913=5D input: HDA Intel PCH Dock Line Out as /devices/pci0000=
:00/0000:00:1b.0/sound/card0/input10
=5B    2.969197=5D input: HDA Intel PCH Headphone as /devices/pci0000:00/=
0000:00:1b.0/sound/card0/input11
=5B    2.969764=5D Key type big_key registered
=5B    2.977941=5D Key type encrypted registered
=5B    2.980754=5D printk: console =5Bnetcon0=5D enabled
=5B    2.980759=5D netconsole: network logging started
=5B    2.980866=5D rtc_cmos 00:01: setting system clock to 2018-10-19 14:=
01:35 UTC (1539957695)
=5B    2.981448=5D cfg80211: Loading compiled-in X.509 certificates for r=
egulatory database
=5B    2.986344=5D cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9c=
ea7'
=5B    2.986880=5D platform regulatory.0: Direct firmware load for regula=
tory.db failed with error -2
=5B    2.986921=5D cfg80211: failed to load regulatory.db
=5B    2.987054=5D ALSA device list:
=5B    2.987060=5D   =230: HDA Intel PCH at 0xf7730000 irq 29
=5B    3.154776=5D usb 1-1: new high-speed USB device number 2 using ehci=
-pci
=5B    3.162733=5D usb 2-1: new high-speed USB device number 2 using ehci=
-pci
=5B    3.172264=5D usb 4-4: new SuperSpeed Gen 1 USB device number 2 usin=
g xhci_hcd
=5B    3.183842=5D snd_hda_codec_generic hdaudioC1D0: autoconfig for Gene=
ric: line_outs=3D0 (0x0/0x0/0x0/0x0/0x0) type:line
=5B    3.183865=5D snd_hda_codec_generic hdaudioC1D0:    speaker_outs=3D0=
 (0x0/0x0/0x0/0x0/0x0)
=5B    3.183882=5D snd_hda_codec_generic hdaudioC1D0:    hp_outs=3D0 (0x0=
/0x0/0x0/0x0/0x0)
=5B    3.183899=5D snd_hda_codec_generic hdaudioC1D0:    mono: mono_out=
=3D0x0
=5B    3.183921=5D snd_hda_codec_generic hdaudioC1D0:    dig-out=3D0x5/0x=
0
=5B    3.183945=5D snd_hda_codec_generic hdaudioC1D0:    inputs:
=5B    3.185792=5D usb 4-4: New USB device found, idVendor=3D413c, idProd=
uct=3D5534, bcdDevice=3D41.00
=5B    3.185824=5D usb 4-4: New USB device strings: Mfr=3D2, Product=3D3,=
 SerialNumber=3D0
=5B    3.185832=5D usb 4-4: Product: USB5534
=5B    3.185840=5D usb 4-4: Manufacturer: SMSC
=5B    3.188714=5D hub 4-4:1.0: USB hub found
=5B    3.189352=5D hub 4-4:1.0: 3 ports detected
=5B    3.200013=5D ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)=

=5B    3.201796=5D ata2.00: ATAPI: MATSHITA DVD+/-RW UJ8C2, 1.02, max UDM=
A/133
=5B    3.204440=5D ata2.00: configured for UDMA/133
=5B    3.210037=5D scsi 1:0:0:0: CD-ROM            MATSHITA DVD+-RW UJ8C2=
    1.02 PQ: 0 ANSI: 5
=5B    3.221864=5D snd_hda_codec_generic hdaudioC1D1: autoconfig for Gene=
ric: line_outs=3D0 (0x0/0x0/0x0/0x0/0x0) type:line
=5B    3.221886=5D snd_hda_codec_generic hdaudioC1D1:    speaker_outs=3D0=
 (0x0/0x0/0x0/0x0/0x0)
=5B    3.221901=5D snd_hda_codec_generic hdaudioC1D1:    hp_outs=3D0 (0x0=
/0x0/0x0/0x0/0x0)
=5B    3.221916=5D snd_hda_codec_generic hdaudioC1D1:    mono: mono_out=
=3D0x0
=5B    3.221930=5D snd_hda_codec_generic hdaudioC1D1:    dig-out=3D0x5/0x=
0
=5B    3.221946=5D snd_hda_codec_generic hdaudioC1D1:    inputs:
=5B    3.255312=5D sr 1:0:0:0: =5Bsr0=5D scsi3-mmc drive: 24x/24x writer =
dvd-ram cd/rw xa/form2 cdda tray
=5B    3.255343=5D cdrom: Uniform CD-ROM driver Revision: 3.20
=5B    3.257591=5D sr 1:0:0:0: Attached scsi CD-ROM sr0
=5B    3.259740=5D snd_hda_codec_generic hdaudioC1D2: autoconfig for Gene=
ric: line_outs=3D0 (0x0/0x0/0x0/0x0/0x0) type:line
=5B    3.259755=5D snd_hda_codec_generic hdaudioC1D2:    speaker_outs=3D0=
 (0x0/0x0/0x0/0x0/0x0)
=5B    3.259763=5D snd_hda_codec_generic hdaudioC1D2:    hp_outs=3D0 (0x0=
/0x0/0x0/0x0/0x0)
=5B    3.259771=5D snd_hda_codec_generic hdaudioC1D2:    mono: mono_out=
=3D0x0
=5B    3.259780=5D snd_hda_codec_generic hdaudioC1D2:    dig-out=3D0x5/0x=
0
=5B    3.259790=5D snd_hda_codec_generic hdaudioC1D2:    inputs:
=5B    3.283726=5D usb 1-1: New USB device found, idVendor=3D8087, idProd=
uct=3D0024, bcdDevice=3D 0.00
=5B    3.283749=5D usb 1-1: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
=5B    3.285887=5D hub 1-1:1.0: USB hub found
=5B    3.286163=5D hub 1-1:1.0: 6 ports detected
=5B    3.291057=5D usb 2-1: New USB device found, idVendor=3D8087, idProd=
uct=3D0024, bcdDevice=3D 0.00
=5B    3.291065=5D usb 2-1: New USB device strings: Mfr=3D0, Product=3D0,=
 SerialNumber=3D0
=5B    3.291990=5D hub 2-1:1.0: USB hub found
=5B    3.292248=5D hub 2-1:1.0: 8 ports detected
=5B    3.297687=5D snd_hda_codec_generic hdaudioC1D3: autoconfig for Gene=
ric: line_outs=3D0 (0x0/0x0/0x0/0x0/0x0) type:line
=5B    3.297701=5D snd_hda_codec_generic hdaudioC1D3:    speaker_outs=3D0=
 (0x0/0x0/0x0/0x0/0x0)
=5B    3.297713=5D snd_hda_codec_generic hdaudioC1D3:    hp_outs=3D0 (0x0=
/0x0/0x0/0x0/0x0)
=5B    3.297723=5D snd_hda_codec_generic hdaudioC1D3:    mono: mono_out=
=3D0x0
=5B    3.297733=5D snd_hda_codec_generic hdaudioC1D3:    dig-out=3D0x5/0x=
0
=5B    3.297743=5D snd_hda_codec_generic hdaudioC1D3:    inputs:
=5B    3.298653=5D usb 3-1: new low-speed USB device number 2 using xhci_=
hcd
=5B    3.333463=5D input: HDA NVidia HDMI as /devices/pci0000:00/0000:00:=
01.0/0000:01:00.1/sound/card1/input12
=5B    3.334126=5D input: HDA NVidia HDMI as /devices/pci0000:00/0000:00:=
01.0/0000:01:00.1/sound/card1/input13
=5B    3.334764=5D input: HDA NVidia HDMI as /devices/pci0000:00/0000:00:=
01.0/0000:01:00.1/sound/card1/input14
=5B    3.335346=5D input: HDA NVidia HDMI as /devices/pci0000:00/0000:00:=
01.0/0000:01:00.1/sound/card1/input15
=5B    3.336779=5D tsc: Refined TSC clocksource calibration: 2691.256 MHz=

=5B    3.336815=5D clocksource: tsc: mask: 0xffffffffffffffff max_cycles:=
 0x26caf9f5a53, max_idle_ns: 440795206420 ns
=5B    3.337011=5D clocksource: Switched to clocksource tsc
=5B    3.441596=5D usb 3-1: New USB device found, idVendor=3D045e, idProd=
uct=3D0023, bcdDevice=3D 1.21
=5B    3.441669=5D usb 3-1: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
=5B    3.441679=5D usb 3-1: Product: Microsoft Trackball Optical=AE
=5B    3.441687=5D usb 3-1: Manufacturer: Microsoft
=5B    3.454548=5D input: Microsoft Microsoft Trackball Optical=AE as /de=
vices/pci0000:00/0000:00:14.0/usb3/3-1/3-1:1.0/0003:045E:0023.0001/input/=
input16
=5B    3.455854=5D hid-generic 0003:045E:0023.0001: input,hidraw0: USB HI=
D v1.00 Mouse =5BMicrosoft Microsoft Trackball Optical=AE=5D on usb-0000:=
00:14.0-1/input0
=5B    3.466643=5D input: PS/2 Generic Mouse as /devices/platform/i8042/s=
erio1/input/input7
=5B    3.567983=5D ata5: SATA link down (SStatus 0 SControl 300)
=5B    3.568709=5D usb 2-1.7: new high-speed USB device number 3 using eh=
ci-pci
=5B    3.570679=5D usb 3-4: new high-speed USB device number 3 using xhci=
_hcd
=5B    3.647356=5D usb 2-1.7: New USB device found, idVendor=3D413c, idPr=
oduct=3D2513, bcdDevice=3Da0.05
=5B    3.647372=5D usb 2-1.7: New USB device strings: Mfr=3D0, Product=3D=
0, SerialNumber=3D0
=5B    3.648557=5D hub 2-1.7:1.0: USB hub found
=5B    3.648899=5D hub 2-1.7:1.0: 3 ports detected
=5B    3.698323=5D usb 3-4: New USB device found, idVendor=3D413c, idProd=
uct=3D2134, bcdDevice=3D41.00
=5B    3.698335=5D usb 3-4: New USB device strings: Mfr=3D1, Product=3D2,=
 SerialNumber=3D0
=5B    3.698343=5D usb 3-4: Product: USB2134
=5B    3.698351=5D usb 3-4: Manufacturer: SMSC
=5B    3.699809=5D hub 3-4:1.0: USB hub found
=5B    3.699913=5D hub 3-4:1.0: 3 ports detected
=5B    3.714700=5D usb 2-1.8: new full-speed USB device number 4 using eh=
ci-pci
=5B    3.816333=5D usb 2-1.8: New USB device found, idVendor=3D0a5c, idPr=
oduct=3D5801, bcdDevice=3D 1.01
=5B    3.816347=5D usb 2-1.8: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D3
=5B    3.816355=5D usb 2-1.8: Product: 5880
=5B    3.816364=5D usb 2-1.8: Manufacturer: Broadcom Corp
=5B    3.816372=5D usb 2-1.8: SerialNumber: 0123456789ABCD
=5B    3.817239=5D usb 2-1.8: config 0 descriptor??
=5B    3.880427=5D ata6: SATA link down (SStatus 0 SControl 300)
=5B    3.892097=5D Freeing unused kernel image memory: 3680K
=5B    3.893840=5D Write protecting the kernel read-only data: 24576k
=5B    3.895534=5D Freeing unused kernel image memory: 2016K
=5B    3.896452=5D Freeing unused kernel image memory: 1588K
=5B    3.896952=5D x86/mm: Checked W+X mappings: passed, no W+X pages fou=
nd.
=5B    3.896955=5D x86/mm: Checking user space page tables
=5B    3.897018=5D x86/mm: Checked W+X mappings: passed, no W+X pages fou=
nd.
=5B    3.897020=5D Run /init as init process
=5B    3.897567=5D _warn_unseeded_randomness: 12 callbacks suppressed
=5B    3.897578=5D random: get_random_bytes called from create_elf_tables=
+0xd1/0x9e0 with crng_init=3D1
=5B    3.973093=5D systemd=5B1=5D: systemd 239 running in system mode. (+=
PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP =
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN =
+PCRE2 default-hierarchy=3Dhybrid)
=5B    3.984945=5D systemd=5B1=5D: Detected architecture x86-64.
=5B    3.984956=5D systemd=5B1=5D: Running in initial RAM disk.
=5B    3.988645=5D usb 3-4.1: new low-speed USB device number 4 using xhc=
i_hcd
=5B    3.992564=5D systemd=5B1=5D: Set hostname to <turing-police.cc.vt.e=
du>.
=5B    4.081566=5D input: PS/2 Generic Mouse as /devices/platform/i8042/s=
erio1/input/input18
=5B    4.084418=5D usb 3-4.1: New USB device found, idVendor=3D0e8f, idPr=
oduct=3D0020, bcdDevice=3D 2.80
=5B    4.084440=5D usb 3-4.1: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D0
=5B    4.084451=5D usb 3-4.1: Product: PS2toUSB Adapter
=5B    4.084462=5D usb 3-4.1: Manufacturer: GASIA
=5B    4.093887=5D input: GASIA PS2toUSB Adapter as /devices/pci0000:00/0=
000:00:14.0/usb3/3-4/3-4.1/3-4.1:1.0/0003:0E8F:0020.0002/input/input19
=5B    4.147871=5D hid-generic 0003:0E8F:0020.0002: input,hidraw1: USB HI=
D v1.10 Keyboard =5BGASIA PS2toUSB Adapter=5D on usb-0000:00:14.0-4.1/inp=
ut0
=5B    4.153269=5D input: GASIA PS2toUSB Adapter Mouse as /devices/pci000=
0:00/0000:00:14.0/usb3/3-4/3-4.1/3-4.1:1.1/0003:0E8F:0020.0003/input/inpu=
t20
=5B    4.153942=5D input: GASIA PS2toUSB Adapter System Control as /devic=
es/pci0000:00/0000:00:14.0/usb3/3-4/3-4.1/3-4.1:1.1/0003:0E8F:0020.0003/i=
nput/input21
=5B    4.165872=5D random: systemd: uninitialized urandom read (16 bytes =
read)
=5B    4.166315=5D systemd=5B1=5D: Listening on Journal Socket.
=5B    4.166434=5D random: systemd: uninitialized urandom read (16 bytes =
read)
=5B    4.166450=5D systemd=5B1=5D: Reached target Swap.
=5B    4.166486=5D random: systemd: uninitialized urandom read (16 bytes =
read)
=5B    4.166671=5D systemd=5B1=5D: Listening on udev Kernel Socket.
=5B    4.167001=5D systemd=5B1=5D: Listening on udev Control Socket.
=5B    4.173342=5D systemd=5B1=5D: Starting Apply Kernel Variables...
=5B    4.174204=5D systemd=5B1=5D: Listening on Journal Audit Socket.
=5B    4.177208=5D random: get_random_bytes called from key_alloc+0x261/0=
x480 with crng_init=3D1
=5B    4.179580=5D random: get_random_bytes called from create_elf_tables=
+0xd1/0x9e0 with crng_init=3D1
=5B    4.214314=5D input: GASIA PS2toUSB Adapter Consumer Control as /dev=
ices/pci0000:00/0000:00:14.0/usb3/3-4/3-4.1/3-4.1:1.1/0003:0E8F:0020.0003=
/input/input22
=5B    4.214951=5D hid-generic 0003:0E8F:0020.0003: input,hidraw2: USB HI=
D v1.10 Mouse =5BGASIA PS2toUSB Adapter=5D on usb-0000:00:14.0-4.1/input1=

=5B    4.252545=5D audit: type=3D1130 audit(1539957696.770:2): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsyst=
emd-tmpfiles-setup-dev comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/sys=
temd=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    4.352372=5D audit: type=3D1130 audit(1539957696.870:3): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsyst=
emd-vconsole-setup comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=
=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    4.352417=5D audit: type=3D1131 audit(1539957696.870:4): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsyst=
emd-vconsole-setup comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=
=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    4.466994=5D audit: type=3D1130 audit(1539957696.985:5): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsyst=
emd-journald comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 ho=
stname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    4.873193=5D audit: type=3D1130 audit(1539957697.391:6): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddrac=
ut-cmdline comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 host=
name=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    4.910667=5D audit: type=3D1130 audit(1539957697.429:7): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsyst=
emd-udevd comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 hostn=
ame=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    4.921454=5D _warn_unseeded_randomness: 11 callbacks suppressed
=5B    4.921462=5D random: get_random_bytes called from key_alloc+0x261/0=
x480 with crng_init=3D1
=5B    4.923808=5D random: get_random_bytes called from create_elf_tables=
+0xd1/0x9e0 with crng_init=3D1
=5B    4.998200=5D random: get_random_bytes called from key_alloc+0x261/0=
x480 with crng_init=3D1
=5B    5.361765=5D audit: type=3D1130 audit(1539957697.880:8): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsyst=
emd-udev-trigger comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=
=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    5.427646=5D audit: type=3D1130 audit(1539957697.945:9): pid=3D1 ui=
d=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplym=
outh-start comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 host=
name=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    5.497621=5D e1000e 0000:00:19.0 eno1: renamed from eth0
=5B    6.142415=5D _warn_unseeded_randomness: 7 callbacks suppressed
=5B    6.142423=5D random: get_random_bytes called from key_alloc+0x261/0=
x480 with crng_init=3D1
=5B    6.144353=5D random: get_random_bytes called from create_elf_tables=
+0xd1/0x9e0 with crng_init=3D1
=5B    6.172968=5D random: get_random_bytes called from key_alloc+0x261/0=
x480 with crng_init=3D1
=5B    6.177829=5D audit: type=3D1130 audit(1539957698.696:10): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsys=
temd-ask-password-plymouth comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd=
/systemd=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    6.323550=5D audit: type=3D1130 audit(1539957698.841:11): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsys=
temd-vconsole-setup comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/system=
d=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    6.323573=5D audit: type=3D1131 audit(1539957698.841:12): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsys=
temd-vconsole-setup comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/system=
d=22 hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B    9.620451=5D random: crng init done
=5B    9.620491=5D random: 3 get_random_xx warning(s) missed due to ratel=
imiting
=5B    9.620497=5D random: 7 urandom warning(s) missed due to ratelimitin=
g
=5B   17.294623=5D audit: type=3D1130 audit(1539957709.812:13): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsys=
temd-cryptsetup=40luks=5Cx2d665bb147=5Cx2d9e39=5Cx2d4003=5Cx2db3ae=5Cx2d7=
be925f51a97 comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   18.310262=5D audit: type=3D1130 audit(1539957710.828:14): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddra=
cut-initqueue comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   18.439865=5D audit: type=3D1130 audit(1539957710.958:15): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsys=
temd-fsck-root comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 =
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   18.491117=5D EXT4-fs (dm-3): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   18.812684=5D audit: type=3D1130 audit(1539957711.330:16): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dini=
trd-parse-etc comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   18.812835=5D audit: type=3D1131 audit(1539957711.331:17): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dini=
trd-parse-etc comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   19.010976=5D audit: type=3D1130 audit(1539957711.529:18): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsys=
temd-fsck=40dev-mapper-turing=5Cx2d=5Cx2dpolice=5Cx2d00 comm=3D=22systemd=
=22 exe=3D=22/usr/lib/systemd/systemd=22 hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
=5B   19.041197=5D EXT4-fs (dm-1): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   19.092825=5D audit: type=3D1130 audit(1539957711.611:19): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddra=
cut-cmdline comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   19.092983=5D audit: type=3D1131 audit(1539957711.611:20): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddra=
cut-cmdline comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   19.099864=5D audit: type=3D1130 audit(1539957711.618:21): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddra=
cut-initqueue comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   19.099888=5D audit: type=3D1131 audit(1539957711.618:22): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddra=
cut-initqueue comm=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 h=
ostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
=5B   19.335138=5D systemd-journald=5B238=5D: Received SIGTERM from PID 1=
 (systemd).
=5B   19.446220=5D printk: systemd: 16 output lines suppressed due to rat=
elimiting
=5B   20.125159=5D SELinux:  Class xdp_socket not defined in policy.
=5B   20.125182=5D SELinux: the above unknown classes and permissions wil=
l be denied
=5B   20.125211=5D SELinux:  policy capability network_peer_controls=3D1
=5B   20.125214=5D SELinux:  policy capability open_perms=3D1
=5B   20.125216=5D SELinux:  policy capability extended_socket_class=3D1
=5B   20.125218=5D SELinux:  policy capability always_check_network=3D0
=5B   20.125220=5D SELinux:  policy capability cgroup_seclabel=3D1
=5B   20.125222=5D SELinux:  policy capability nnp_nosuid_transition=3D1
=5B   20.178695=5D SELinux:  Context unconfined_u:object_r:etc_t:s0 is no=
t valid (left unmapped).
=5B   20.213990=5D systemd=5B1=5D: Successfully loaded SELinux policy in =
299.965ms.
=5B   20.343167=5D systemd=5B1=5D: Relabelled /dev, /run and /sys/fs/cgro=
up in 52.448ms.
=5B   20.353859=5D systemd=5B1=5D: systemd 239 running in system mode. (+=
PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP =
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN =
+PCRE2 default-hierarchy=3Dhybrid)
=5B   20.367005=5D systemd=5B1=5D: Detected architecture x86-64.
=5B   20.372240=5D systemd=5B1=5D: Set hostname to <turing-police.cc.vt.e=
du>.
=5B   20.444199=5D SELinux:  Context unconfined_u:object_r:default_t:s0 i=
s not valid (left unmapped).
=5B   21.216349=5D systemd=5B1=5D: Stopped Switch Root.
=5B   21.217202=5D systemd=5B1=5D: systemd-journald.service: Service has =
no hold-off time (RestartSec=3D0), scheduling restart.
=5B   21.217256=5D systemd=5B1=5D: systemd-journald.service: Scheduled re=
start job, restart counter is at 1.
=5B   21.217325=5D systemd=5B1=5D: Stopped Journal Service.
=5B   21.221802=5D systemd=5B1=5D: Starting Journal Service...
=5B   21.232387=5D systemd=5B1=5D: Listening on LVM2 poll daemon socket.
=5B   21.238978=5D systemd=5B1=5D: Listening on LVM2 metadata daemon sock=
et.
=5B   21.301767=5D Adding 4079612k swap on /dev/mapper/turing--police-swa=
p.  Priority:-2 extents:1 across:4079612k FS
=5B   21.388446=5D EXT4-fs (dm-1): re-mounted. Opts: (null)
=5B   21.396950=5D EXT4-fs (dm-3): re-mounted. Opts: (null)
=5B   21.996389=5D EXT4-fs (sda2): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   22.156899=5D FAT-fs (sda1): Volume was not properly unmounted. Some=
 data may be corrupt. Please run fsck.
=5B   22.508322=5D bcma-pci-bridge 0000:03:00.0: enabling device (0100 ->=
 0102)
=5B   22.510902=5D bcma: bus0: Found chip with id 0x4313, rev 0x01 and pa=
ckage 0x08
=5B   22.510946=5D bcma: bus0: Core 0 found: ChipCommon (manuf 0x4BF, id =
0x800, rev 0x24, class 0x0)
=5B   22.510981=5D bcma: bus0: Core 1 found: IEEE 802.11 (manuf 0x4BF, id=
 0x812, rev 0x18, class 0x0)
=5B   22.511046=5D bcma: bus0: Core 2 found: PCIe (manuf 0x4BF, id 0x820,=
 rev 0x11, class 0x0)
=5B   22.532872=5D bcma: bus0: Bus registered
=5B   22.582835=5D e1000e 0000:00:19.0 eth0: renamed from eno1
=5B   22.734308=5D kauditd_printk_skb: 55 callbacks suppressed
=5B   22.734312=5D audit: type=3D1400 audit(1539957715.252:67): avc:  den=
ied  =7B execute_no_trans =7D for  pid=3D842 comm=3D=22(spawn)=22 path=3D=
=22/usr/lib/virtualbox/VBoxCreateUSBNode.sh=22 dev=3D=22dm-1=22 ino=3D174=
8 scontext=3Dsystem_u:system_r:udev_t:s0-s15:c0.c1023 tcontext=3Dsystem_u=
:object_r:textrel_shlib_t:s0 tclass=3Dfile permissive=3D1
=5B   22.737040=5D audit: type=3D1400 audit(1539957715.255:68): avc:  den=
ied  =7B search =7D for  pid=3D790 comm=3D=22systemd-udevd=22 name=3D=22/=
=22 dev=3D=22efivarfs=22 ino=3D10399 scontext=3Dsystem_u:system_r:udev_t:=
s0-s15:c0.c1023 tcontext=3Dsystem_u:object_r:efivarfs_t:s0 tclass=3Ddir p=
ermissive=3D1
=5B   22.737367=5D audit: type=3D1300 audit(1539957715.255:68): arch=3Dc0=
00003e syscall=3D257 success=3Dno exit=3D-2 a0=3Dffffff9c a1=3D55696d5e85=
30 a2=3D80100 a3=3D0 items=3D0 ppid=3D784 pid=3D790 auid=3D4294967295 uid=
=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=
=3D(none) ses=3D4294967295 comm=3D=22systemd-udevd=22 exe=3D=22/usr/lib/s=
ystemd/systemd-udevd=22 subj=3Dsystem_u:system_r:udev_t:s0-s15:c0.c1023 k=
ey=3D(null)
=5B   22.737638=5D audit: type=3D1327 audit(1539957715.255:68): proctitle=
=3D=22/usr/lib/systemd/systemd-udevd=22
=5B   22.746591=5D audit: type=3D1300 audit(1539957715.252:67): arch=3Dc0=
00003e syscall=3D59 success=3Dyes exit=3D0 a0=3D7ffe2c867fa0 a1=3D7ffe2c8=
67ba0 a2=3D55696d5a9c10 a3=3D8 items=3D0 ppid=3D800 pid=3D842 auid=3D4294=
967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgi=
d=3D0 tty=3D(none) ses=3D4294967295 comm=3D=22VBoxCreateUSBNo=22 exe=3D=
=22/usr/bin/bash=22 subj=3Dsystem_u:system_r:udev_t:s0-s15:c0.c1023 key=
=3D(null)
=5B   22.751829=5D audit: type=3D1327 audit(1539957715.252:67): proctitle=
=3D2F62696E2F7368002F7573722F6C69622F7669727475616C626F782F56426F78437265=
6174655553424E6F64652E7368003138390030003039
=5B   22.854935=5D cryptd: max_cpu_qlen set to 1000
=5B   22.888986=5D input: Dell WMI hotkeys as /devices/platform/PNP0C14:0=
0/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/i=
nput23
=5B   23.269914=5D audit: type=3D1400 audit(1539957715.785:69): avc:  den=
ied  =7B execute_no_trans =7D for  pid=3D899 comm=3D=22(spawn)=22 path=3D=
=22/usr/lib/virtualbox/VBoxCreateUSBNode.sh=22 dev=3D=22dm-1=22 ino=3D174=
8 scontext=3Dsystem_u:system_r:udev_t:s0-s15:c0.c1023 tcontext=3Dsystem_u=
:object_r:textrel_shlib_t:s0 tclass=3Dfile permissive=3D1
=5B   23.272750=5D audit: type=3D1300 audit(1539957715.785:69): arch=3Dc0=
00003e syscall=3D59 success=3Dyes exit=3D0 a0=3D7ffe2c868060 a1=3D7ffe2c8=
67c60 a2=3D55696d5b6830 a3=3D8 items=3D0 ppid=3D788 pid=3D899 auid=3D4294=
967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgid=3D0 fsgi=
d=3D0 tty=3D(none) ses=3D4294967295 comm=3D=22VBoxCreateUSBNo=22 exe=3D=
=22/usr/bin/bash=22 subj=3Dsystem_u:system_r:udev_t:s0-s15:c0.c1023 key=
=3D(null)
=5B   23.272832=5D audit: type=3D1327 audit(1539957715.785:69): proctitle=
=3D2F62696E2F7368002F7573722F6C69622F7669727475616C626F782F56426F78437265=
6174655553424E6F64652E73680031383900333835003039
=5B   23.279855=5D dell_laptop: Using dell-rbtn acpi driver for receiving=
 events
=5B   23.402242=5D audit: type=3D1130 audit(1539957715.920:70): pid=3D1 u=
id=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t=
:s0-s15:c0.c1023 msg=3D'unit=3Dlvm2-lvmetad comm=3D=22systemd=22 exe=3D=
=22/usr/lib/systemd/systemd=22 hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
=5B   23.456203=5D brcmsmac bcma0:1: mfg 4bf core 812 rev 24 class 0 irq =
17
=5B   23.459893=5D ieee80211 phy0: Selected rate control algorithm 'minst=
rel_ht'
=5B   25.034192=5D EXT4-fs (dm-11): mounted filesystem with ordered data =
mode. Opts: (null)
=5B   25.178789=5D EXT4-fs (dm-5): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   25.269434=5D EXT4-fs (dm-6): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   25.293041=5D EXT4-fs (dm-9): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   25.365755=5D EXT4-fs (dm-8): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   25.391504=5D EXT4-fs (dm-4): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   25.425652=5D EXT4-fs (dm-12): mounted filesystem with ordered data =
mode. Opts: (null)
=5B   25.465811=5D EXT4-fs (dm-10): mounted filesystem with ordered data =
mode. Opts: (null)
=5B   25.536588=5D systemd-journald=5B765=5D: Received request to flush r=
untime journal from PID 1
=5B   25.622039=5D EXT4-fs (dm-7): mounted filesystem with ordered data m=
ode. Opts: (null)
=5B   30.728066=5D kauditd_printk_skb: 31 callbacks suppressed
=5B   30.728071=5D audit: type=3D1131 audit(1539957723.246:100): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_=
t:s0-s15:c0.c1023 msg=3D'unit=3Dsystemd-rfkill comm=3D=22systemd=22 exe=
=3D=22/usr/lib/systemd/systemd=22 hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
=5B  106.465848=5D audit: type=3D1130 audit(1539957798.984:101): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_=
t:s0-s15:c0.c1023 msg=3D'unit=3Drun-r93ac4731e4724fd6a3670e7d0c417522 com=
m=3D=22systemd=22 exe=3D=22/usr/lib/systemd/systemd=22 hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
=5B  106.564711=5D dennis: q ffff9e3c57152000 =21=3D rl->q ffff9e3a8fe480=
40
=5B  106.564713=5D dennis: bio: ffff9e3a8fcf5400, root: ffffffffbbdd89e0
=5B  106.564761=5D BUG: unable to handle kernel NULL pointer dereference =
at 0000000000000000
=5B  106.568786=5D PGD 0 P4D 0=20
=5B  106.570761=5D Oops: 0000 =5B=231=5D PREEMPT SMP PTI
=5B  106.573115=5D CPU: 2 PID: 1205 Comm: sh Tainted: G                T =
4.19.0-rc8-next-20181016-dirty =23639
=5B  106.575617=5D Hardware name: Dell Inc. Latitude E6530/07Y85M, BIOS A=
21 02/21/2018
=5B  106.578184=5D RIP: 0010:__get_request+0x31/0x7e0
=5B  106.580389=5D Code: 89 e5 41 57 41 56 41 55 49 89 fd 41 54 41 89 f4 =
53 48 83 ec 50 48 8b 1f 48 85 d2 48 89 55 b8 89 4d c0 44 89 45 c4 48 8b 4=
3 18 <48> 8b 00 48 89 45 b0 0f 84 ba 03 00 00 48 8b 42 58 48 85 c0 48 89
=5B  106.582244=5D RSP: 0018:ffffbb0081f0f570 EFLAGS: 00010086
=5B  106.584014=5D RAX: 0000000000000000 RBX: ffff9e3a8fe48040 RCX: 00000=
00000000000
=5B  106.585775=5D RDX: ffff9e3c54b0ba00 RSI: 0000000000080000 RDI: ffff9=
e3c5a427840
=5B  106.587520=5D RBP: ffffbb0081f0f5e8 R08: 0000000000600000 R09: 00000=
00000000001
=5B  106.589271=5D R10: 0000000000000001 R11: 0000000000000000 R12: 00000=
00000080000
=5B  106.591026=5D R13: ffff9e3c5a427840 R14: 0000000000000001 R15: ffff9=
e3c54b0ba00
=5B  106.592775=5D FS:  00007fa7d28f2740(0000) GS:ffff9e3c5d800000(0000) =
knlGS:0000000000000000
=5B  106.594531=5D CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
=5B  106.596289=5D CR2: 0000000000000000 CR3: 000000041b34a001 CR4: 00000=
000001606e0
=5B  106.598056=5D Call Trace:
=5B  106.599813=5D  ? printk+0x59/0x75
=5B  106.601566=5D  get_request+0x40a/0xb70
=5B  106.603331=5D  ? remove_wait_queue+0x70/0x70
=5B  106.605091=5D  blk_queue_bio+0x23b/0x760
=5B  106.606844=5D  generic_make_request+0x2fe/0x570
=5B  106.608591=5D  submit_bio+0x4d/0x190
=5B  106.610335=5D  ? submit_bio+0x4d/0x190
=5B  106.612077=5D  ? bio_add_page+0x4b/0x60
=5B  106.613813=5D  ext4_mpage_readpages+0x814/0xed4
=5B  106.615540=5D  ext4_readpages+0x55/0x60
=5B  106.617270=5D  read_pages+0x72/0x190
=5B  106.618987=5D  __do_page_cache_readahead+0x1f6/0x220
=5B  106.620709=5D  ondemand_readahead+0x2ae/0x4f0
=5B  106.622425=5D  page_cache_sync_readahead+0x112/0x250
=5B  106.624149=5D  generic_file_buffered_read+0x542/0xf70
=5B  106.625875=5D  ? mark_held_locks+0x52/0x80
=5B  106.627605=5D  generic_file_read_iter+0xd0/0x140
=5B  106.629335=5D  ext4_file_read_iter+0x6c/0x80
=5B  106.631073=5D  new_sync_read+0x121/0x1a0
=5B  106.632858=5D  __vfs_read+0x49/0x60
=5B  106.634563=5D  vfs_read+0x152/0x250
=5B  106.636254=5D  kernel_read+0x43/0x60
=5B  106.637928=5D  prepare_binprm+0x19b/0x1f0
=5B  106.639570=5D  __do_execve_file+0x5ca/0xbc0
=5B  106.641200=5D  __x64_sys_execve+0x38/0x50
=5B  106.642808=5D  do_syscall_64+0x8f/0xa52
=5B  106.644376=5D  ? trace_hardirqs_off_thunk+0x1a/0x1c
=5B  106.645928=5D  entry_SYSCALL_64_after_hwframe+0x49/0xbe
=5B  106.647439=5D RIP: 0033:0x7fa7d29beb5b
=5B  106.648934=5D Code: 41 89 01 eb da 66 2e 0f 1f 84 00 00 00 00 00 f7 =
d8 64 41 89 01 eb d6 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 3b 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 62 0f 00 f7 d8 64 89 01 48
=5B  106.650516=5D RSP: 002b:00007ffdb151b488 EFLAGS: 00000246 ORIG_RAX: =
000000000000003b
=5B  106.652086=5D RAX: ffffffffffffffda RBX: 000056104981a570 RCX: 00007=
fa7d29beb5b
=5B  106.653633=5D RDX: 0000561049818140 RSI: 000056104981a180 RDI: 00005=
6104981a570
=5B  106.655149=5D RBP: 0000000000000000 R08: 00007fa7d2aba710 R09: 00000=
00000000000
=5B  106.656681=5D R10: 0000000000000000 R11: 0000000000000246 R12: 00000=
00000000008
=5B  106.658197=5D R13: 000056104981a180 R14: 0000561049818140 R15: 00000=
00000000000
=5B  106.659724=5D Modules linked in: brcmsmac cordic brcmutil x86_pkg_te=
mp_thermal dell_laptop crct10dif_pclmul dell_smm_hwmon crc32_pclmul crc32=
c_intel dell_wmi ghash_clmulni_intel cryptd dell_smbios dell_wmi_descript=
or bcma dell_smo8800 dell_rbtn mei_wdt vfat fat
=5B  106.662984=5D CR2: 0000000000000000
=5B  106.664598=5D ---=5B end trace e53d8917bc40055f =5D---

--==_Exmh_1539962862_31020--


--==_Exmh_1539964356_3102P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8n9xI0DS38y7CIcAQI2twf+O4qCxVwTGWLz/UEc2qgq7Vy0J9QXyjQX
jPO68yc+uZFnFDo1FYGTc/Wnf/1+SVr1nU4h1Zoh1+RSkeqxSWI0btKYBur6ANrO
KnDltDSttfBPP7BfRrCxwnTUIbz8FtPVPDo7D/ucTx4KfCf569bE4sn5/qDoifPe
81hziZxQM5oDKuldbs8vpjMnq0/PVIqHNM6YWaZ2giYVChDneF5xKDyNCA9JYRkt
fO7QI/bKcneYwiZD6Gg5IzhlxgWKK4apoXicaiP+rTCY4RJRS8r2LJ51WDbAkfiR
Wm3C/xV8BhypFT+/j6nS/ocVv1PvWzQr20XKMNaMVUXUocUiV2ezkw==
=JcSP
-----END PGP SIGNATURE-----

--==_Exmh_1539964356_3102P--
