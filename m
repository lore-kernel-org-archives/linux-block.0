Return-Path: <yyt168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170905115356.GA16927@infradead.org>
References: <20170823175815.3646-1-hch@lst.de> <20170823175815.3646-11-hch@lst.de>
 <1503512512.2484.16.camel@wdc.com> <20170824085954.GD19504@lst.de>
 <1503605798.2899.43.camel@wdc.com> <20170905115356.GA16927@infradead.org>
From: Tony Yang <yyt168@gmail.com>
Date: Mon, 11 Sep 2017 14:34:50 +0800
Message-ID: <CADL4p-r_VLZra=_KF6vK8fc7RtOQCnPEnb8Jfj8P3tFcv35dnA@mail.gmail.com>
Subject: Re: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>, "hch@lst.de" <hch@lst.de>
Content-Type: multipart/alternative; boundary="001a114052dcb893980558e41f52"
List-ID: <linux-block@vger.kernel.org>

--001a114052dcb893980558e41f52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, All

I use this url : http://git.infradead.org/users/hch/block.git/shortlog/
refs/heads/nvme-mpath to download core.c and nvme.h=EF=BC=8C And then compi=
le the
kernel, the following error, unable to compile successful, what is the
problem? Thanks

drivers/net/wireless/wl3501_cs.c: In function =E2=80=98wl3501_receive=E2=80=
=99:
drivers/net/wireless/wl3501_cs.c:765: warning: =E2=80=98next_addr=E2=80=99 =
may be used
uninitialized in this function
drivers/net/wireless/wl3501_cs.c:794: warning: =E2=80=98next_addr1=E2=80=99=
 may be used
uninitialized in this function
  CC [M]  drivers/net/wireless/rndis_wlan.o
  CC [M]  drivers/net/wireless/mac80211_hwsim.o
  LD      drivers/net/built-in.o
  CC [M]  drivers/net/dummy.o
  CC [M]  drivers/net/ifb.o
  CC [M]  drivers/net/macvlan.o
drivers/net/macvlan.c: In function =E2=80=98macvlan_changelink=E2=80=99:
drivers/net/macvlan.c:1387: warning: =E2=80=98mode=E2=80=99 may be used uni=
nitialized in
this function
  CC [M]  drivers/net/macvtap.o
  CC [M]  drivers/net/mii.o
  CC [M]  drivers/net/mdio.o
  CC [M]  drivers/net/netconsole.o
  CC [M]  drivers/net/tun.o
  CC [M]  drivers/net/veth.o
  CC [M]  drivers/net/virtio_net.o
  CC [M]  drivers/net/vxlan.o
  CC [M]  drivers/net/sungem_phy.o
  LD      drivers/nfc/built-in.o
  LD      drivers/nvme/host/built-in.o
  CC [M]  drivers/nvme/host/core.o
In file included from drivers/nvme/host/core.c:32:
drivers/nvme/host/nvme.h:22:28: error: linux/sed-opal.h: No such file or
directory
In file included from drivers/nvme/host/core.c:32:
drivers/nvme/host/nvme.h:86: error: field =E2=80=98result=E2=80=99 has inco=
mplete type
drivers/nvme/host/nvme.h:220: error: expected specifier-qualifier-list
before =E2=80=98uuid_t=E2=80=99
drivers/nvme/host/nvme.h: In function =E2=80=98nvme_cleanup_cmd=E2=80=99:
drivers/nvme/host/nvme.h:288: error: =E2=80=98struct request=E2=80=99 has n=
o member named
=E2=80=98rq_flags=E2=80=99
drivers/nvme/host/nvme.h:288: error: =E2=80=98RQF_SPECIAL_PAYLOAD=E2=80=99 =
undeclared
(first use in this function)
drivers/nvme/host/nvme.h:288: error: (Each undeclared identifier is
reported only once
drivers/nvme/host/nvme.h:288: error: for each function it appears in.)
drivers/nvme/host/nvme.h:289: error: =E2=80=98struct request=E2=80=99 has n=
o member named
=E2=80=98special_vec=E2=80=99
drivers/nvme/host/nvme.h:290: error: =E2=80=98struct request=E2=80=99 has n=
o member named
=E2=80=98special_vec=E2=80=99
drivers/nvme/host/nvme.h: At top level:
drivers/nvme/host/nvme.h:295: error: parameter 3 (=E2=80=98result=E2=80=99)=
 has incomplete
type
drivers/nvme/host/nvme.h: In function =E2=80=98nvme_end_request=E2=80=99:
drivers/nvme/host/nvme.h:301: error: too few arguments to function
=E2=80=98blk_mq_complete_request=E2=80=99
drivers/nvme/host/nvme.h: At top level:
drivers/nvme/host/nvme.h:341: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_cmd=E2=80=99
drivers/nvme/host/core.c:109: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_error_status=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_failover_rq=E2=80=99:
drivers/nvme/host/core.c:169: error: =E2=80=98NVME_SC_ONCS_NOT_SUPPORTED=E2=
=80=99
undeclared (first use in this function)
drivers/nvme/host/core.c:184: error: =E2=80=98NVME_SC_UNWRITTEN_BLOCK=E2=80=
=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:190: error: implicit declaration of function
=E2=80=98blk_steal_bios=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_complete_rq=E2=80=99:
drivers/nvme/host/core.c:217: error: too many arguments to function
=E2=80=98blk_mq_requeue_request=E2=80=99
drivers/nvme/host/core.c:221: error: implicit declaration of function
=E2=80=98nvme_error_status=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_cancel_request=E2=80=99=
:
drivers/nvme/host/core.c:239: error: too few arguments to function
=E2=80=98blk_mq_complete_request=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_destroy_ns_head=E2=80=
=99:
drivers/nvme/host/core.c:334: error: =E2=80=98struct nvme_ns_head=E2=80=99 =
has no member
named =E2=80=98ref=E2=80=99
drivers/nvme/host/core.c:334: error: type defaults to =E2=80=98int=E2=80=99=
 in declaration
of =E2=80=98__mptr=E2=80=99
drivers/nvme/host/core.c:334: warning: initialization from incompatible
pointer type
drivers/nvme/host/core.c:334: error: =E2=80=98struct nvme_ns_head=E2=80=99 =
has no member
named =E2=80=98ref=E2=80=99
drivers/nvme/host/core.c:343: error: =E2=80=98struct nvme_ns_head=E2=80=99 =
has no member
named =E2=80=98instance=E2=80=99
drivers/nvme/host/core.c:345: error: =E2=80=98struct nvme_ns_head=E2=80=99 =
has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_put_ns_head=E2=80=99:
drivers/nvme/host/core.c:352: error: =E2=80=98struct nvme_ns_head=E2=80=99 =
has no member
named =E2=80=98ref=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_alloc_request=E2=80=99:
drivers/nvme/host/core.c:408: error: =E2=80=98REQ_OP_DRV_OUT=E2=80=99 undec=
lared (first use
in this function)
drivers/nvme/host/core.c:408: error: =E2=80=98REQ_OP_DRV_IN=E2=80=99 undecl=
ared (first use
in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_toggle_streams=E2=80=99=
:
drivers/nvme/host/core.c:433: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:433: error: =E2=80=98nvme_admin_directive_send=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:434: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:434: error: =E2=80=98NVME_NSID_ALL=E2=80=99 undecl=
ared (first use
in this function)
drivers/nvme/host/core.c:435: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:435: error: =E2=80=98NVME_DIR_SND_ID_OP_ENABLE=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:436: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:436: error: =E2=80=98NVME_DIR_IDENTIFY=E2=80=99 un=
declared (first
use in this function)
drivers/nvme/host/core.c:437: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:437: error: =E2=80=98NVME_DIR_STREAMS=E2=80=99 und=
eclared (first
use in this function)
drivers/nvme/host/core.c:438: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:438: error: =E2=80=98NVME_DIR_ENDIR=E2=80=99 undec=
lared (first use
in this function)
drivers/nvme/host/core.c: At top level:
drivers/nvme/host/core.c:454: warning: =E2=80=98struct streams_directive_pa=
rams=E2=80=99
declared inside parameter list
drivers/nvme/host/core.c:454: warning: its scope is only this definition or
declaration, which is probably not what you want
drivers/nvme/host/core.c: In function =E2=80=98nvme_get_stream_params=E2=80=
=99:
drivers/nvme/host/core.c:459: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:461: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:461: error: =E2=80=98nvme_admin_directive_recv=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:462: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:463: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:463: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:464: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:464: error: =E2=80=98NVME_DIR_RCV_ST_OP_PARAM=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:465: error: =E2=80=98struct nvme_command=E2=80=99 =
has no member
named =E2=80=98directive=E2=80=99
drivers/nvme/host/core.c:465: error: =E2=80=98NVME_DIR_STREAMS=E2=80=99 und=
eclared (first
use in this function)
drivers/nvme/host/core.c:467: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c: In function =E2=80=98nvme_configure_directives=E2=
=80=99:
drivers/nvme/host/core.c:472: error: storage size of =E2=80=98s=E2=80=99 is=
n=E2=80=99t known
drivers/nvme/host/core.c:475: error: =E2=80=98NVME_CTRL_OACS_DIRECTIVES=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:484: error: =E2=80=98NVME_NSID_ALL=E2=80=99 undecl=
ared (first use
in this function)
drivers/nvme/host/core.c:489: error: =E2=80=98BLK_MAX_WRITE_HINTS=E2=80=99 =
undeclared
(first use in this function)
drivers/nvme/host/core.c:472: warning: unused variable =E2=80=98s=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_assign_write_stream=E2=
=80=99:
drivers/nvme/host/core.c:509: error: variable =E2=80=98streamid=E2=80=99 ha=
s initializer
but incomplete type
drivers/nvme/host/core.c:509: error: =E2=80=98struct request=E2=80=99 has n=
o member named
=E2=80=98write_hint=E2=80=99
drivers/nvme/host/core.c:509: error: storage size of =E2=80=98streamid=E2=
=80=99 isn=E2=80=99t known
drivers/nvme/host/core.c:511: error: =E2=80=98WRITE_LIFE_NOT_SET=E2=80=99 u=
ndeclared (first
use in this function)
drivers/nvme/host/core.c:511: error: =E2=80=98WRITE_LIFE_NONE=E2=80=99 unde=
clared (first
use in this function)
drivers/nvme/host/core.c:518: error: =E2=80=98NVME_RW_DTYPE_STREAMS=E2=80=
=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:522: error: =E2=80=98struct request_queue=E2=80=99=
 has no member
named =E2=80=98write_hints=E2=80=99
drivers/nvme/host/core.c:522: error: =E2=80=98struct request_queue=E2=80=99=
 has no member
named =E2=80=98write_hints=E2=80=99
drivers/nvme/host/core.c:522: error: =E2=80=98struct request_queue=E2=80=99=
 has no member
named =E2=80=98write_hints=E2=80=99
drivers/nvme/host/core.c:522: error: =E2=80=98struct request_queue=E2=80=99=
 has no member
named =E2=80=98write_hints=E2=80=99
drivers/nvme/host/core.c:522: error: type defaults to =E2=80=98int=E2=80=99=
 in declaration
of =E2=80=98type name=E2=80=99
drivers/nvme/host/core.c:522: error: type defaults to =E2=80=98int=E2=80=99=
 in declaration
of =E2=80=98type name=E2=80=99
drivers/nvme/host/core.c:522: error: negative width in bit-field
=E2=80=98<anonymous>=E2=80=99
drivers/nvme/host/core.c:523: error: =E2=80=98struct request_queue=E2=80=99=
 has no member
named =E2=80=98write_hints=E2=80=99
drivers/nvme/host/core.c:509: warning: unused variable =E2=80=98streamid=E2=
=80=99
drivers/nvme/host/core.c: At top level:
drivers/nvme/host/core.c:534: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_discard=E2=80=99
drivers/nvme/host/core.c:574: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_rw=E2=80=99
drivers/nvme/host/core.c:630: error: expected =E2=80=98=3D=E2=80=99, =E2=80=
=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or
=E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_cmd=E2=80=99
drivers/nvme/host/core.c:666: error: =E2=80=98nvme_setup_cmd=E2=80=99 undec=
lared here (not
in a function)
drivers/nvme/host/core.c:666: error: type defaults to =E2=80=98int=E2=80=99=
 in declaration
of =E2=80=98nvme_setup_cmd=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98__nvme_submit_sync_cmd=E2=80=
=99:
drivers/nvme/host/core.c:693: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c: In function =E2=80=98__nvme_submit_user_cmd=E2=80=
=99:
drivers/nvme/host/core.c:740: error: =E2=80=98struct bio=E2=80=99 has no me=
mber named
=E2=80=98bi_disk=E2=80=99
drivers/nvme/host/core.c: At top level:
drivers/nvme/host/core.c:806: error: expected declaration specifiers or
=E2=80=98...=E2=80=99 before =E2=80=98blk_status_t=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_keep_alive_end_io=E2=80=
=99:
drivers/nvme/host/core.c:812: error: =E2=80=98status=E2=80=99 undeclared (f=
irst use in this
function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_keep_alive=E2=80=99:
drivers/nvme/host/core.c:838: warning: passing argument 5 of
=E2=80=98blk_execute_rq_nowait=E2=80=99 from incompatible pointer type
./include/linux/blkdev.h:837: note: expected =E2=80=98void (*)(struct reque=
st *,
int)=E2=80=99 but argument is of type =E2=80=98void (*)(struct request *)=
=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_identify_ctrl=E2=80=99:
drivers/nvme/host/core.c:882: error: =E2=80=98NVME_ID_CNS_CTRL=E2=80=99 und=
eclared (first
use in this function)
drivers/nvme/host/core.c: At top level:
drivers/nvme/host/core.c:896: error: expected declaration specifiers or
=E2=80=98...=E2=80=99 before =E2=80=98uuid_t=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_identify_ns_descs=E2=80=
=99:
drivers/nvme/host/core.c:906: error: =E2=80=98NVME_ID_CNS_NS_DESC_LIST=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:908: error: =E2=80=98NVME_IDENTIFY_DATA_SIZE=E2=80=
=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:920: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:923: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:924: error: =E2=80=98NVME_NIDT_EUI64=E2=80=99 unde=
clared (first
use in this function)
drivers/nvme/host/core.c:925: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:925: error: =E2=80=98NVME_NIDT_EUI64_LEN=E2=80=99 =
undeclared
(first use in this function)
drivers/nvme/host/core.c:928: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:932: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:934: error: =E2=80=98NVME_NIDT_NGUID=E2=80=99 unde=
clared (first
use in this function)
drivers/nvme/host/core.c:935: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:935: error: =E2=80=98NVME_NIDT_NGUID_LEN=E2=80=99 =
undeclared
(first use in this function)
drivers/nvme/host/core.c:938: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:942: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:944: error: =E2=80=98NVME_NIDT_UUID=E2=80=99 undec=
lared (first use
in this function)
drivers/nvme/host/core.c:945: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:945: error: =E2=80=98NVME_NIDT_UUID_LEN=E2=80=99 u=
ndeclared (first
use in this function)
drivers/nvme/host/core.c:948: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:952: error: implicit declaration of function
=E2=80=98uuid_copy=E2=80=99
drivers/nvme/host/core.c:952: error: =E2=80=98uuid=E2=80=99 undeclared (fir=
st use in this
function)
drivers/nvme/host/core.c:952: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:956: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:960: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c: In function =E2=80=98nvme_identify_ns_list=E2=80=
=99:
drivers/nvme/host/core.c:972: error: =E2=80=98NVME_ID_CNS_NS_ACTIVE_LIST=E2=
=80=99
undeclared (first use in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_identify_ns=E2=80=99:
drivers/nvme/host/core.c:987: error: =E2=80=98NVME_ID_CNS_NS=E2=80=99 undec=
lared (first use
in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_set_features=E2=80=99:
drivers/nvme/host/core.c:1007: error: storage size of =E2=80=98res=E2=80=99=
 isn=E2=80=99t known
drivers/nvme/host/core.c:1007: warning: unused variable =E2=80=98res=E2=80=
=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_ioctl=E2=80=99:
drivers/nvme/host/core.c:1162: error: implicit declaration of function
=E2=80=98is_sed_ioctl=E2=80=99
drivers/nvme/host/core.c:1163: error: implicit declaration of function
=E2=80=98sed_ioctl=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_config_discard=E2=80=99=
:
drivers/nvme/host/core.c:1275: error: =E2=80=98NVME_DSM_MAX_RANGES=E2=80=99=
 undeclared
(first use in this function)
drivers/nvme/host/core.c:1288: error: implicit declaration of function
=E2=80=98blk_queue_max_discard_segments=E2=80=99
drivers/nvme/host/core.c:1292: error: implicit declaration of function
=E2=80=98blk_queue_max_write_zeroes_sectors=E2=80=99
drivers/nvme/host/core.c: At top level:
drivers/nvme/host/core.c:1296: error: expected declaration specifiers or
=E2=80=98...=E2=80=99 before =E2=80=98uuid_t=E2=80=99
drivers/nvme/host/core.c:1298:33: error: macro "NVME_VS" passed 3
arguments, but takes just 2
drivers/nvme/host/core.c: In function =E2=80=98nvme_report_ns_ids=E2=80=99:
drivers/nvme/host/core.c:1298: error: =E2=80=98NVME_VS=E2=80=99 undeclared =
(first use in
this function)
drivers/nvme/host/core.c:1300:33: error: macro "NVME_VS" passed 3
arguments, but takes just 2
drivers/nvme/host/core.c:1302:33: error: macro "NVME_VS" passed 3
arguments, but takes just 2
drivers/nvme/host/core.c:1306: error: =E2=80=98uuid=E2=80=99 undeclared (fi=
rst use in this
function)
drivers/nvme/host/core.c:1306: error: too many arguments to function
=E2=80=98nvme_identify_ns_descs=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98__nvme_revalidate_disk=E2=80=
=99:
drivers/nvme/host/core.c:1326: error: =E2=80=98struct nvme_id_ns=E2=80=99 h=
as no member
named =E2=80=98noiob=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_revalidate_disk=E2=80=
=99:
drivers/nvme/host/core.c:1361: error: =E2=80=98uuid_t=E2=80=99 undeclared (=
first use in
this function)
drivers/nvme/host/core.c:1361: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:1362: warning: ISO C90 forbids mixed declarations
and code
drivers/nvme/host/core.c:1378: error: =E2=80=98uuid=E2=80=99 undeclared (fi=
rst use in this
function)
drivers/nvme/host/core.c:1378: error: too many arguments to function
=E2=80=98nvme_report_ns_ids=E2=80=99
drivers/nvme/host/core.c:1379: error: implicit declaration of function
=E2=80=98uuid_equal=E2=80=99
drivers/nvme/host/core.c:1379: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_enable_ctrl=E2=80=99:
drivers/nvme/host/core.c:1589: error: =E2=80=98NVME_CC_AMS_RR=E2=80=99 unde=
clared (first
use in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_configure_timestamp=E2=
=80=99:
drivers/nvme/host/core.c:1656: error: =E2=80=98NVME_CTRL_ONCS_TIMESTAMP=E2=
=80=99 undeclared
(first use in this function)
drivers/nvme/host/core.c:1660: error: =E2=80=98NVME_FEAT_TIMESTAMP=E2=80=99=
 undeclared
(first use in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_configure_apst=E2=80=99=
:
drivers/nvme/host/core.c:1704: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:1726: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:1777: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:1783: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:1877:33: error: macro "NVME_VS" passed 3
arguments, but takes just 2
drivers/nvme/host/core.c: In function =E2=80=98nvme_init_subnqn=E2=80=99:
drivers/nvme/host/core.c:1877: error: =E2=80=98NVME_VS=E2=80=99 undeclared =
(first use in
this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_init_subsystem=E2=80=99=
:
drivers/nvme/host/core.c:1946: error: =E2=80=98struct nvme_id_ctrl=E2=80=99=
 has no member
named =E2=80=98cmic=E2=80=99
drivers/nvme/host/core.c:1995:33: error: macro "NVME_VS" passed 3
arguments, but takes just 2
drivers/nvme/host/core.c: In function =E2=80=98nvme_init_identify=E2=80=99:
drivers/nvme/host/core.c:1995: error: =E2=80=98NVME_VS=E2=80=99 undeclared =
(first use in
this function)
drivers/nvme/host/core.c:2091: error: =E2=80=98struct nvme_id_ctrl=E2=80=99=
 has no member
named =E2=80=98hmpre=E2=80=99
drivers/nvme/host/core.c:2092: error: =E2=80=98struct nvme_id_ctrl=E2=80=99=
 has no member
named =E2=80=98hmmin=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98wwid_show=E2=80=99:
drivers/nvme/host/core.c:2254: error: implicit declaration of function
=E2=80=98uuid_is_null=E2=80=99
drivers/nvme/host/core.c:2254: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:2255: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98uuid_show=E2=80=99:
drivers/nvme/host/core.c:2292: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:2297: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_ns_attrs_are_visible=E2=
=80=99:
drivers/nvme/host/core.c:2333: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_make_request=E2=80=99:
drivers/nvme/host/core.c:2506: error: =E2=80=98struct bio=E2=80=99 has no m=
ember named
=E2=80=98bi_disk=E2=80=99
drivers/nvme/host/core.c:2508: error: implicit declaration of function
=E2=80=98generic_make_request_fast=E2=80=99
drivers/nvme/host/core.c:2518: error: =E2=80=98struct bio=E2=80=99 has no m=
ember named
=E2=80=98bi_status=E2=80=99
drivers/nvme/host/core.c:2518: error: =E2=80=98BLK_STS_IOERR=E2=80=99 undec=
lared (first use
in this function)
drivers/nvme/host/core.c: In function =E2=80=98__nvme_find_ns_head=E2=80=99=
:
drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2554: error: type defaults to =E2=80=98int=E2=80=
=99 in declaration
of =E2=80=98__mptr=E2=80=99
drivers/nvme/host/core.c:2554: warning: initialization from incompatible
pointer type
drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2554: error: type defaults to =E2=80=98int=E2=80=
=99 in declaration
of =E2=80=98__mptr=E2=80=99
drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2555: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98ref=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98__nvme_check_ids=E2=80=99:
drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2569: error: type defaults to =E2=80=98int=E2=80=
=99 in declaration
of =E2=80=98__mptr=E2=80=99
drivers/nvme/host/core.c:2569: warning: initialization from incompatible
pointer type
drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2569: error: type defaults to =E2=80=98int=E2=80=
=99 in declaration
of =E2=80=98__mptr=E2=80=99
drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2570: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:2571: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:2571: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_alloc_ns_head=E2=80=99:
drivers/nvme/host/core.c:2599: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98ref=E2=80=99
drivers/nvme/host/core.c:2602: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:2602: error: too many arguments to function
=E2=80=98nvme_report_ns_ids=E2=80=99
drivers/nvme/host/core.c:2622: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98instance=E2=80=99
drivers/nvme/host/core.c:2623: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98instance=E2=80=99
drivers/nvme/host/core.c:2633: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98instance=E2=80=99
drivers/nvme/host/core.c:2635: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98entry=E2=80=99
drivers/nvme/host/core.c:2639: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98instance=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_init_ns_head=E2=80=99:
drivers/nvme/host/core.c:2670: error: =E2=80=98uuid_t=E2=80=99 undeclared (=
first use in
this function)
drivers/nvme/host/core.c:2670: error: expected =E2=80=98;=E2=80=99 before =
=E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c:2672: error: =E2=80=98uuid=E2=80=99 undeclared (fi=
rst use in this
function)
drivers/nvme/host/core.c:2672: error: too many arguments to function
=E2=80=98nvme_report_ns_ids=E2=80=99
drivers/nvme/host/core.c:2673: error: =E2=80=98struct nvme_ns_head=E2=80=99=
 has no member
named =E2=80=98uuid=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_setup_streams_ns=E2=80=
=99:
drivers/nvme/host/core.c:2722: error: storage size of =E2=80=98s=E2=80=99 i=
sn=E2=80=99t known
drivers/nvme/host/core.c:2722: warning: unused variable =E2=80=98s=E2=80=99
drivers/nvme/host/core.c:2964:33: error: macro "NVME_VS" passed 3
arguments, but takes just 2
drivers/nvme/host/core.c: In function =E2=80=98nvme_scan_work=E2=80=99:
drivers/nvme/host/core.c:2964: error: =E2=80=98NVME_VS=E2=80=99 undeclared =
(first use in
this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_ctrl_pp_status=E2=80=99=
:
drivers/nvme/host/core.c:3038: error: =E2=80=98NVME_CSTS_PP=E2=80=99 undecl=
ared (first use
in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_get_fw_slot_info=E2=80=
=99:
drivers/nvme/host/core.c:3046: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:3051: error: =E2=80=98NVME_NSID_ALL=E2=80=99 undec=
lared (first use
in this function)
drivers/nvme/host/core.c:3052: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:3054: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c: In function =E2=80=98nvme_complete_async_event=E2=
=80=99:
drivers/nvme/host/core.c:3095: error: dereferencing pointer to incomplete
type
drivers/nvme/host/core.c:3118: error: =E2=80=98NVME_AER_NOTICE_FW_ACT_START=
ING=E2=80=99
undeclared (first use in this function)
drivers/nvme/host/core.c: In function =E2=80=98nvme_kill_queues=E2=80=99:
drivers/nvme/host/core.c:3294: error: implicit declaration of function
=E2=80=98blk_mq_unquiesce_queue=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_wait_freeze_timeout=E2=
=80=99:
drivers/nvme/host/core.c:3330: error: implicit declaration of function
=E2=80=98blk_mq_freeze_queue_wait_timeout=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_wait_freeze=E2=80=99:
drivers/nvme/host/core.c:3344: error: implicit declaration of function
=E2=80=98blk_mq_freeze_queue_wait=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_start_freeze=E2=80=99:
drivers/nvme/host/core.c:3355: error: implicit declaration of function
=E2=80=98blk_freeze_queue_start=E2=80=99
drivers/nvme/host/core.c: In function =E2=80=98nvme_stop_queues=E2=80=99:
drivers/nvme/host/core.c:3366: error: implicit declaration of function
=E2=80=98blk_mq_quiesce_queue=E2=80=99
make[3]: *** [drivers/nvme/host/core.o] Error 1
make[2]: *** [drivers/nvme/host] Error 2
make[1]: *** [drivers/nvme] Error 2
make: *** [drivers] Error 2
[root@cescel01 linux-4.8.17]#

2017-09-05 19:53 GMT+08:00 Christoph Hellwig <hch@infradead.org>:

> On Thu, Aug 24, 2017 at 08:17:32PM +0000, Bart Van Assche wrote:
> > For NVMe over RDMA, how about the simulate_network_failure_loop()
> function in
> > https://github.com/bvanassche/srp-test/blob/master/lib/functions? It
> simulates
> > a network failure by writing into the reset_controller sysfs attribute.
>
> FYI, I've tested lots of reset_controllers.  But automatic them is of
> course even better.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

--001a114052dcb893980558e41f52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,=C2=A0All<table cellpadding=3D"0" class=3D"gmail-cf gma=
il-gJ" style=3D"font-size:14px"><tbody><tr class=3D"gmail-acZ"><td class=3D=
"gmail-gF gmail-gK" style=3D"width:646px"><table cellpadding=3D"0" class=3D=
"gmail-cf gmail-ix" style=3D"width:646px"><tbody><tr><td><div><span name=3D=
"Christoph Hellwig" class=3D"gmail-gD" style=3D"font-size:14px">I use this =
url :=C2=A0</span><a href=3D"http://git.infradead.org/users/hch/block.git/s=
hortlog/refs/heads/nvme-mpath" rel=3D"noreferrer" target=3D"_blank">http://=
git.infradead.org/<wbr>users/hch/block.git/shortlog/<wbr>refs/heads/nvme-mp=
ath</a>=C2=A0to download core.c and nvme.h=EF=BC=8C=C2=A0And then compile t=
he kernel, the following error, unable to compile successful, what is the p=
roblem? Thanks</div><div><br></div><div><div>drivers/net/wireless/wl3501_cs=
.c: In function =E2=80=98wl3501_receive=E2=80=99:</div><div>drivers/net/wir=
eless/wl3501_cs.c:765: warning: =E2=80=98next_addr=E2=80=99 may be used uni=
nitialized in this function</div><div>drivers/net/wireless/wl3501_cs.c:794:=
 warning: =E2=80=98next_addr1=E2=80=99 may be used uninitialized in this fu=
nction</div><div>=C2=A0 CC [M] =C2=A0drivers/net/wireless/rndis_wlan.o</div=
><div>=C2=A0 CC [M] =C2=A0drivers/net/wireless/mac80211_hwsim.o</div><div>=
=C2=A0 LD =C2=A0 =C2=A0 =C2=A0drivers/net/built-in.o</div><div>=C2=A0 CC [M=
] =C2=A0drivers/net/dummy.o</div><div>=C2=A0 CC [M] =C2=A0drivers/net/ifb.o=
</div><div>=C2=A0 CC [M] =C2=A0drivers/net/macvlan.o</div><div>drivers/net/=
macvlan.c: In function =E2=80=98macvlan_changelink=E2=80=99:</div><div>driv=
ers/net/macvlan.c:1387: warning: =E2=80=98mode=E2=80=99 may be used uniniti=
alized in this function</div><div>=C2=A0 CC [M] =C2=A0drivers/net/macvtap.o=
</div><div>=C2=A0 CC [M] =C2=A0drivers/net/mii.o</div><div>=C2=A0 CC [M] =
=C2=A0drivers/net/mdio.o</div><div>=C2=A0 CC [M] =C2=A0drivers/net/netconso=
le.o</div><div>=C2=A0 CC [M] =C2=A0drivers/net/tun.o</div><div>=C2=A0 CC [M=
] =C2=A0drivers/net/veth.o</div><div>=C2=A0 CC [M] =C2=A0drivers/net/virtio=
_net.o</div><div>=C2=A0 CC [M] =C2=A0drivers/net/vxlan.o</div><div>=C2=A0 C=
C [M] =C2=A0drivers/net/sungem_phy.o</div><div>=C2=A0 LD =C2=A0 =C2=A0 =C2=
=A0drivers/nfc/built-in.o</div><div>=C2=A0 LD =C2=A0 =C2=A0 =C2=A0drivers/n=
vme/host/built-in.o</div><div>=C2=A0 CC [M] =C2=A0drivers/nvme/host/core.o<=
/div><div>In file included from drivers/nvme/host/core.c:32:</div><div>driv=
ers/nvme/host/nvme.h:22:28: error: linux/sed-opal.h: No such file or direct=
ory</div><div>In file included from drivers/nvme/host/core.c:32:</div><div>=
drivers/nvme/host/nvme.h:86: error: field =E2=80=98result=E2=80=99 has inco=
mplete type</div><div>drivers/nvme/host/nvme.h:220: error: expected specifi=
er-qualifier-list before =E2=80=98uuid_t=E2=80=99</div><div>drivers/nvme/ho=
st/nvme.h: In function =E2=80=98nvme_cleanup_cmd=E2=80=99:</div><div>driver=
s/nvme/host/nvme.h:288: error: =E2=80=98struct request=E2=80=99 has no memb=
er named =E2=80=98rq_flags=E2=80=99</div><div>drivers/nvme/host/nvme.h:288:=
 error: =E2=80=98RQF_SPECIAL_PAYLOAD=E2=80=99 undeclared (first use in this=
 function)</div><div>drivers/nvme/host/nvme.h:288: error: (Each undeclared =
identifier is reported only once</div><div>drivers/nvme/host/nvme.h:288: er=
ror: for each function it appears in.)</div><div>drivers/nvme/host/nvme.h:2=
89: error: =E2=80=98struct request=E2=80=99 has no member named =E2=80=98sp=
ecial_vec=E2=80=99</div><div>drivers/nvme/host/nvme.h:290: error: =E2=80=98=
struct request=E2=80=99 has no member named =E2=80=98special_vec=E2=80=99</=
div><div>drivers/nvme/host/nvme.h: At top level:</div><div>drivers/nvme/hos=
t/nvme.h:295: error: parameter 3 (=E2=80=98result=E2=80=99) has incomplete =
type</div><div>drivers/nvme/host/nvme.h: In function =E2=80=98nvme_end_requ=
est=E2=80=99:</div><div>drivers/nvme/host/nvme.h:301: error: too few argume=
nts to function =E2=80=98blk_mq_complete_request=E2=80=99</div><div>drivers=
/nvme/host/nvme.h: At top level:</div><div>drivers/nvme/host/nvme.h:341: er=
ror: expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=
=99, =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=
=98nvme_setup_cmd=E2=80=99</div><div>drivers/nvme/host/core.c:109: error: e=
xpected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =
=E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98nv=
me_error_status=E2=80=99</div><div>drivers/nvme/host/core.c: In function =
=E2=80=98nvme_failover_rq=E2=80=99:</div><div>drivers/nvme/host/core.c:169:=
 error: =E2=80=98NVME_SC_ONCS_NOT_SUPPORTED=E2=80=99 undeclared (first use =
in this function)</div><div>drivers/nvme/host/core.c:184: error: =E2=80=98N=
VME_SC_UNWRITTEN_BLOCK=E2=80=99 undeclared (first use in this function)</di=
v><div>drivers/nvme/host/core.c:190: error: implicit declaration of functio=
n =E2=80=98blk_steal_bios=E2=80=99</div><div>drivers/nvme/host/core.c: In f=
unction =E2=80=98nvme_complete_rq=E2=80=99:</div><div>drivers/nvme/host/cor=
e.c:217: error: too many arguments to function =E2=80=98blk_mq_requeue_requ=
est=E2=80=99</div><div>drivers/nvme/host/core.c:221: error: implicit declar=
ation of function =E2=80=98nvme_error_status=E2=80=99</div><div>drivers/nvm=
e/host/core.c: In function =E2=80=98nvme_cancel_request=E2=80=99:</div><div=
>drivers/nvme/host/core.c:239: error: too few arguments to function =E2=80=
=98blk_mq_complete_request=E2=80=99</div><div>drivers/nvme/host/core.c: In =
function =E2=80=98nvme_destroy_ns_head=E2=80=99:</div><div>drivers/nvme/hos=
t/core.c:334: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member na=
med =E2=80=98ref=E2=80=99</div><div>drivers/nvme/host/core.c:334: error: ty=
pe defaults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98__mptr=E2=
=80=99</div><div>drivers/nvme/host/core.c:334: warning: initialization from=
 incompatible pointer type</div><div>drivers/nvme/host/core.c:334: error: =
=E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98ref=E2=
=80=99</div><div>drivers/nvme/host/core.c:343: error: =E2=80=98struct nvme_=
ns_head=E2=80=99 has no member named =E2=80=98instance=E2=80=99</div><div>d=
rivers/nvme/host/core.c:345: error: =E2=80=98struct nvme_ns_head=E2=80=99 h=
as no member named =E2=80=98entry=E2=80=99</div><div>drivers/nvme/host/core=
.c: In function =E2=80=98nvme_put_ns_head=E2=80=99:</div><div>drivers/nvme/=
host/core.c:352: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member=
 named =E2=80=98ref=E2=80=99</div><div>drivers/nvme/host/core.c: In functio=
n =E2=80=98nvme_alloc_request=E2=80=99:</div><div>drivers/nvme/host/core.c:=
408: error: =E2=80=98REQ_OP_DRV_OUT=E2=80=99 undeclared (first use in this =
function)</div><div>drivers/nvme/host/core.c:408: error: =E2=80=98REQ_OP_DR=
V_IN=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvm=
e/host/core.c: In function =E2=80=98nvme_toggle_streams=E2=80=99:</div><div=
>drivers/nvme/host/core.c:433: error: =E2=80=98struct nvme_command=E2=80=99=
 has no member named =E2=80=98directive=E2=80=99</div><div>drivers/nvme/hos=
t/core.c:433: error: =E2=80=98nvme_admin_directive_send=E2=80=99 undeclared=
 (first use in this function)</div><div>drivers/nvme/host/core.c:434: error=
: =E2=80=98struct nvme_command=E2=80=99 has no member named =E2=80=98direct=
ive=E2=80=99</div><div>drivers/nvme/host/core.c:434: error: =E2=80=98NVME_N=
SID_ALL=E2=80=99 undeclared (first use in this function)</div><div>drivers/=
nvme/host/core.c:435: error: =E2=80=98struct nvme_command=E2=80=99 has no m=
ember named =E2=80=98directive=E2=80=99</div><div>drivers/nvme/host/core.c:=
435: error: =E2=80=98NVME_DIR_SND_ID_OP_ENABLE=E2=80=99 undeclared (first u=
se in this function)</div><div>drivers/nvme/host/core.c:436: error: =E2=80=
=98struct nvme_command=E2=80=99 has no member named =E2=80=98directive=E2=
=80=99</div><div>drivers/nvme/host/core.c:436: error: =E2=80=98NVME_DIR_IDE=
NTIFY=E2=80=99 undeclared (first use in this function)</div><div>drivers/nv=
me/host/core.c:437: error: =E2=80=98struct nvme_command=E2=80=99 has no mem=
ber named =E2=80=98directive=E2=80=99</div><div>drivers/nvme/host/core.c:43=
7: error: =E2=80=98NVME_DIR_STREAMS=E2=80=99 undeclared (first use in this =
function)</div><div>drivers/nvme/host/core.c:438: error: =E2=80=98struct nv=
me_command=E2=80=99 has no member named =E2=80=98directive=E2=80=99</div><d=
iv>drivers/nvme/host/core.c:438: error: =E2=80=98NVME_DIR_ENDIR=E2=80=99 un=
declared (first use in this function)</div><div>drivers/nvme/host/core.c: A=
t top level:</div><div>drivers/nvme/host/core.c:454: warning: =E2=80=98stru=
ct streams_directive_params=E2=80=99 declared inside parameter list</div><d=
iv>drivers/nvme/host/core.c:454: warning: its scope is only this definition=
 or declaration, which is probably not what you want</div><div>drivers/nvme=
/host/core.c: In function =E2=80=98nvme_get_stream_params=E2=80=99:</div><d=
iv>drivers/nvme/host/core.c:459: error: dereferencing pointer to incomplete=
 type</div><div>drivers/nvme/host/core.c:461: error: =E2=80=98struct nvme_c=
ommand=E2=80=99 has no member named =E2=80=98directive=E2=80=99</div><div>d=
rivers/nvme/host/core.c:461: error: =E2=80=98nvme_admin_directive_recv=E2=
=80=99 undeclared (first use in this function)</div><div>drivers/nvme/host/=
core.c:462: error: =E2=80=98struct nvme_command=E2=80=99 has no member name=
d =E2=80=98directive=E2=80=99</div><div>drivers/nvme/host/core.c:463: error=
: =E2=80=98struct nvme_command=E2=80=99 has no member named =E2=80=98direct=
ive=E2=80=99</div><div>drivers/nvme/host/core.c:463: error: dereferencing p=
ointer to incomplete type</div><div>drivers/nvme/host/core.c:464: error: =
=E2=80=98struct nvme_command=E2=80=99 has no member named =E2=80=98directiv=
e=E2=80=99</div><div>drivers/nvme/host/core.c:464: error: =E2=80=98NVME_DIR=
_RCV_ST_OP_PARAM=E2=80=99 undeclared (first use in this function)</div><div=
>drivers/nvme/host/core.c:465: error: =E2=80=98struct nvme_command=E2=80=99=
 has no member named =E2=80=98directive=E2=80=99</div><div>drivers/nvme/hos=
t/core.c:465: error: =E2=80=98NVME_DIR_STREAMS=E2=80=99 undeclared (first u=
se in this function)</div><div>drivers/nvme/host/core.c:467: error: derefer=
encing pointer to incomplete type</div><div>drivers/nvme/host/core.c: In fu=
nction =E2=80=98nvme_configure_directives=E2=80=99:</div><div>drivers/nvme/=
host/core.c:472: error: storage size of =E2=80=98s=E2=80=99 isn=E2=80=99t k=
nown</div><div>drivers/nvme/host/core.c:475: error: =E2=80=98NVME_CTRL_OACS=
_DIRECTIVES=E2=80=99 undeclared (first use in this function)</div><div>driv=
ers/nvme/host/core.c:484: error: =E2=80=98NVME_NSID_ALL=E2=80=99 undeclared=
 (first use in this function)</div><div>drivers/nvme/host/core.c:489: error=
: =E2=80=98BLK_MAX_WRITE_HINTS=E2=80=99 undeclared (first use in this funct=
ion)</div><div>drivers/nvme/host/core.c:472: warning: unused variable =E2=
=80=98s=E2=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=98n=
vme_assign_write_stream=E2=80=99:</div><div>drivers/nvme/host/core.c:509: e=
rror: variable =E2=80=98streamid=E2=80=99 has initializer but incomplete ty=
pe</div><div>drivers/nvme/host/core.c:509: error: =E2=80=98struct request=
=E2=80=99 has no member named =E2=80=98write_hint=E2=80=99</div><div>driver=
s/nvme/host/core.c:509: error: storage size of =E2=80=98streamid=E2=80=99 i=
sn=E2=80=99t known</div><div>drivers/nvme/host/core.c:511: error: =E2=80=98=
WRITE_LIFE_NOT_SET=E2=80=99 undeclared (first use in this function)</div><d=
iv>drivers/nvme/host/core.c:511: error: =E2=80=98WRITE_LIFE_NONE=E2=80=99 u=
ndeclared (first use in this function)</div><div>drivers/nvme/host/core.c:5=
18: error: =E2=80=98NVME_RW_DTYPE_STREAMS=E2=80=99 undeclared (first use in=
 this function)</div><div>drivers/nvme/host/core.c:522: error: =E2=80=98str=
uct request_queue=E2=80=99 has no member named =E2=80=98write_hints=E2=80=
=99</div><div>drivers/nvme/host/core.c:522: error: =E2=80=98struct request_=
queue=E2=80=99 has no member named =E2=80=98write_hints=E2=80=99</div><div>=
drivers/nvme/host/core.c:522: error: =E2=80=98struct request_queue=E2=80=99=
 has no member named =E2=80=98write_hints=E2=80=99</div><div>drivers/nvme/h=
ost/core.c:522: error: =E2=80=98struct request_queue=E2=80=99 has no member=
 named =E2=80=98write_hints=E2=80=99</div><div>drivers/nvme/host/core.c:522=
: error: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98=
type name=E2=80=99</div><div>drivers/nvme/host/core.c:522: error: type defa=
ults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98type name=E2=80=99=
</div><div>drivers/nvme/host/core.c:522: error: negative width in bit-field=
 =E2=80=98&lt;anonymous&gt;=E2=80=99</div><div>drivers/nvme/host/core.c:523=
: error: =E2=80=98struct request_queue=E2=80=99 has no member named =E2=80=
=98write_hints=E2=80=99</div><div>drivers/nvme/host/core.c:509: warning: un=
used variable =E2=80=98streamid=E2=80=99</div><div>drivers/nvme/host/core.c=
: At top level:</div><div>drivers/nvme/host/core.c:534: error: expected =E2=
=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=
=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_dis=
card=E2=80=99</div><div>drivers/nvme/host/core.c:574: error: expected =E2=
=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=
=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_rw=
=E2=80=99</div><div>drivers/nvme/host/core.c:630: error: expected =E2=80=98=
=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=
=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98nvme_setup_cmd=E2=80=
=99</div><div>drivers/nvme/host/core.c:666: error: =E2=80=98nvme_setup_cmd=
=E2=80=99 undeclared here (not in a function)</div><div>drivers/nvme/host/c=
ore.c:666: error: type defaults to =E2=80=98int=E2=80=99 in declaration of =
=E2=80=98nvme_setup_cmd=E2=80=99</div><div>drivers/nvme/host/core.c: In fun=
ction =E2=80=98__nvme_submit_sync_cmd=E2=80=99:</div><div>drivers/nvme/host=
/core.c:693: error: dereferencing pointer to incomplete type</div><div>driv=
ers/nvme/host/core.c: In function =E2=80=98__nvme_submit_user_cmd=E2=80=99:=
</div><div>drivers/nvme/host/core.c:740: error: =E2=80=98struct bio=E2=80=
=99 has no member named =E2=80=98bi_disk=E2=80=99</div><div>drivers/nvme/ho=
st/core.c: At top level:</div><div>drivers/nvme/host/core.c:806: error: exp=
ected declaration specifiers or =E2=80=98...=E2=80=99 before =E2=80=98blk_s=
tatus_t=E2=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=98n=
vme_keep_alive_end_io=E2=80=99:</div><div>drivers/nvme/host/core.c:812: err=
or: =E2=80=98status=E2=80=99 undeclared (first use in this function)</div><=
div>drivers/nvme/host/core.c: In function =E2=80=98nvme_keep_alive=E2=80=99=
:</div><div>drivers/nvme/host/core.c:838: warning: passing argument 5 of =
=E2=80=98blk_execute_rq_nowait=E2=80=99 from incompatible pointer type</div=
><div>./include/linux/blkdev.h:837: note: expected =E2=80=98void (*)(struct=
 request *, int)=E2=80=99 but argument is of type =E2=80=98void (*)(struct =
request *)=E2=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=
=98nvme_identify_ctrl=E2=80=99:</div><div>drivers/nvme/host/core.c:882: err=
or: =E2=80=98NVME_ID_CNS_CTRL=E2=80=99 undeclared (first use in this functi=
on)</div><div>drivers/nvme/host/core.c: At top level:</div><div>drivers/nvm=
e/host/core.c:896: error: expected declaration specifiers or =E2=80=98...=
=E2=80=99 before =E2=80=98uuid_t=E2=80=99</div><div>drivers/nvme/host/core.=
c: In function =E2=80=98nvme_identify_ns_descs=E2=80=99:</div><div>drivers/=
nvme/host/core.c:906: error: =E2=80=98NVME_ID_CNS_NS_DESC_LIST=E2=80=99 und=
eclared (first use in this function)</div><div>drivers/nvme/host/core.c:908=
: error: =E2=80=98NVME_IDENTIFY_DATA_SIZE=E2=80=99 undeclared (first use in=
 this function)</div><div>drivers/nvme/host/core.c:920: error: dereferencin=
g pointer to incomplete type</div><div>drivers/nvme/host/core.c:923: error:=
 dereferencing pointer to incomplete type</div><div>drivers/nvme/host/core.=
c:924: error: =E2=80=98NVME_NIDT_EUI64=E2=80=99 undeclared (first use in th=
is function)</div><div>drivers/nvme/host/core.c:925: error: dereferencing p=
ointer to incomplete type</div><div>drivers/nvme/host/core.c:925: error: =
=E2=80=98NVME_NIDT_EUI64_LEN=E2=80=99 undeclared (first use in this functio=
n)</div><div>drivers/nvme/host/core.c:928: error: dereferencing pointer to =
incomplete type</div><div>drivers/nvme/host/core.c:932: error: dereferencin=
g pointer to incomplete type</div><div>drivers/nvme/host/core.c:934: error:=
 =E2=80=98NVME_NIDT_NGUID=E2=80=99 undeclared (first use in this function)<=
/div><div>drivers/nvme/host/core.c:935: error: dereferencing pointer to inc=
omplete type</div><div>drivers/nvme/host/core.c:935: error: =E2=80=98NVME_N=
IDT_NGUID_LEN=E2=80=99 undeclared (first use in this function)</div><div>dr=
ivers/nvme/host/core.c:938: error: dereferencing pointer to incomplete type=
</div><div>drivers/nvme/host/core.c:942: error: dereferencing pointer to in=
complete type</div><div>drivers/nvme/host/core.c:944: error: =E2=80=98NVME_=
NIDT_UUID=E2=80=99 undeclared (first use in this function)</div><div>driver=
s/nvme/host/core.c:945: error: dereferencing pointer to incomplete type</di=
v><div>drivers/nvme/host/core.c:945: error: =E2=80=98NVME_NIDT_UUID_LEN=E2=
=80=99 undeclared (first use in this function)</div><div>drivers/nvme/host/=
core.c:948: error: dereferencing pointer to incomplete type</div><div>drive=
rs/nvme/host/core.c:952: error: implicit declaration of function =E2=80=98u=
uid_copy=E2=80=99</div><div>drivers/nvme/host/core.c:952: error: =E2=80=98u=
uid=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvme=
/host/core.c:952: error: dereferencing pointer to incomplete type</div><div=
>drivers/nvme/host/core.c:956: error: dereferencing pointer to incomplete t=
ype</div><div>drivers/nvme/host/core.c:960: error: dereferencing pointer to=
 incomplete type</div><div>drivers/nvme/host/core.c: In function =E2=80=98n=
vme_identify_ns_list=E2=80=99:</div><div>drivers/nvme/host/core.c:972: erro=
r: =E2=80=98NVME_ID_CNS_NS_ACTIVE_LIST=E2=80=99 undeclared (first use in th=
is function)</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_=
identify_ns=E2=80=99:</div><div>drivers/nvme/host/core.c:987: error: =E2=80=
=98NVME_ID_CNS_NS=E2=80=99 undeclared (first use in this function)</div><di=
v>drivers/nvme/host/core.c: In function =E2=80=98nvme_set_features=E2=80=99=
:</div><div>drivers/nvme/host/core.c:1007: error: storage size of =E2=80=98=
res=E2=80=99 isn=E2=80=99t known</div><div>drivers/nvme/host/core.c:1007: w=
arning: unused variable =E2=80=98res=E2=80=99</div><div>drivers/nvme/host/c=
ore.c: In function =E2=80=98nvme_ioctl=E2=80=99:</div><div>drivers/nvme/hos=
t/core.c:1162: error: implicit declaration of function =E2=80=98is_sed_ioct=
l=E2=80=99</div><div>drivers/nvme/host/core.c:1163: error: implicit declara=
tion of function =E2=80=98sed_ioctl=E2=80=99</div><div>drivers/nvme/host/co=
re.c: In function =E2=80=98nvme_config_discard=E2=80=99:</div><div>drivers/=
nvme/host/core.c:1275: error: =E2=80=98NVME_DSM_MAX_RANGES=E2=80=99 undecla=
red (first use in this function)</div><div>drivers/nvme/host/core.c:1288: e=
rror: implicit declaration of function =E2=80=98blk_queue_max_discard_segme=
nts=E2=80=99</div><div>drivers/nvme/host/core.c:1292: error: implicit decla=
ration of function =E2=80=98blk_queue_max_write_zeroes_sectors=E2=80=99</di=
v><div>drivers/nvme/host/core.c: At top level:</div><div>drivers/nvme/host/=
core.c:1296: error: expected declaration specifiers or =E2=80=98...=E2=80=
=99 before =E2=80=98uuid_t=E2=80=99</div><div>drivers/nvme/host/core.c:1298=
:33: error: macro &quot;NVME_VS&quot; passed 3 arguments, but takes just 2<=
/div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_report_ns_ids=
=E2=80=99:</div><div>drivers/nvme/host/core.c:1298: error: =E2=80=98NVME_VS=
=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvme/ho=
st/core.c:1300:33: error: macro &quot;NVME_VS&quot; passed 3 arguments, but=
 takes just 2</div><div>drivers/nvme/host/core.c:1302:33: error: macro &quo=
t;NVME_VS&quot; passed 3 arguments, but takes just 2</div><div>drivers/nvme=
/host/core.c:1306: error: =E2=80=98uuid=E2=80=99 undeclared (first use in t=
his function)</div><div>drivers/nvme/host/core.c:1306: error: too many argu=
ments to function =E2=80=98nvme_identify_ns_descs=E2=80=99</div><div>driver=
s/nvme/host/core.c: In function =E2=80=98__nvme_revalidate_disk=E2=80=99:</=
div><div>drivers/nvme/host/core.c:1326: error: =E2=80=98struct nvme_id_ns=
=E2=80=99 has no member named =E2=80=98noiob=E2=80=99</div><div>drivers/nvm=
e/host/core.c: In function =E2=80=98nvme_revalidate_disk=E2=80=99:</div><di=
v>drivers/nvme/host/core.c:1361: error: =E2=80=98uuid_t=E2=80=99 undeclared=
 (first use in this function)</div><div>drivers/nvme/host/core.c:1361: erro=
r: expected =E2=80=98;=E2=80=99 before =E2=80=98uuid=E2=80=99</div><div>dri=
vers/nvme/host/core.c:1362: warning: ISO C90 forbids mixed declarations and=
 code</div><div>drivers/nvme/host/core.c:1378: error: =E2=80=98uuid=E2=80=
=99 undeclared (first use in this function)</div><div>drivers/nvme/host/cor=
e.c:1378: error: too many arguments to function =E2=80=98nvme_report_ns_ids=
=E2=80=99</div><div>drivers/nvme/host/core.c:1379: error: implicit declarat=
ion of function =E2=80=98uuid_equal=E2=80=99</div><div>drivers/nvme/host/co=
re.c:1379: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named=
 =E2=80=98uuid=E2=80=99</div><div>drivers/nvme/host/core.c: In function =E2=
=80=98nvme_enable_ctrl=E2=80=99:</div><div>drivers/nvme/host/core.c:1589: e=
rror: =E2=80=98NVME_CC_AMS_RR=E2=80=99 undeclared (first use in this functi=
on)</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_configure=
_timestamp=E2=80=99:</div><div>drivers/nvme/host/core.c:1656: error: =E2=80=
=98NVME_CTRL_ONCS_TIMESTAMP=E2=80=99 undeclared (first use in this function=
)</div><div>drivers/nvme/host/core.c:1660: error: =E2=80=98NVME_FEAT_TIMEST=
AMP=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvme=
/host/core.c: In function =E2=80=98nvme_configure_apst=E2=80=99:</div><div>=
drivers/nvme/host/core.c:1704: error: dereferencing pointer to incomplete t=
ype</div><div>drivers/nvme/host/core.c:1726: error: dereferencing pointer t=
o incomplete type</div><div>drivers/nvme/host/core.c:1777: error: dereferen=
cing pointer to incomplete type</div><div>drivers/nvme/host/core.c:1783: er=
ror: dereferencing pointer to incomplete type</div><div>drivers/nvme/host/c=
ore.c:1877:33: error: macro &quot;NVME_VS&quot; passed 3 arguments, but tak=
es just 2</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_ini=
t_subnqn=E2=80=99:</div><div>drivers/nvme/host/core.c:1877: error: =E2=80=
=98NVME_VS=E2=80=99 undeclared (first use in this function)</div><div>drive=
rs/nvme/host/core.c: In function =E2=80=98nvme_init_subsystem=E2=80=99:</di=
v><div>drivers/nvme/host/core.c:1946: error: =E2=80=98struct nvme_id_ctrl=
=E2=80=99 has no member named =E2=80=98cmic=E2=80=99</div><div>drivers/nvme=
/host/core.c:1995:33: error: macro &quot;NVME_VS&quot; passed 3 arguments, =
but takes just 2</div><div>drivers/nvme/host/core.c: In function =E2=80=98n=
vme_init_identify=E2=80=99:</div><div>drivers/nvme/host/core.c:1995: error:=
 =E2=80=98NVME_VS=E2=80=99 undeclared (first use in this function)</div><di=
v>drivers/nvme/host/core.c:2091: error: =E2=80=98struct nvme_id_ctrl=E2=80=
=99 has no member named =E2=80=98hmpre=E2=80=99</div><div>drivers/nvme/host=
/core.c:2092: error: =E2=80=98struct nvme_id_ctrl=E2=80=99 has no member na=
med =E2=80=98hmmin=E2=80=99</div><div>drivers/nvme/host/core.c: In function=
 =E2=80=98wwid_show=E2=80=99:</div><div>drivers/nvme/host/core.c:2254: erro=
r: implicit declaration of function =E2=80=98uuid_is_null=E2=80=99</div><di=
v>drivers/nvme/host/core.c:2254: error: =E2=80=98struct nvme_ns_head=E2=80=
=99 has no member named =E2=80=98uuid=E2=80=99</div><div>drivers/nvme/host/=
core.c:2255: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member nam=
ed =E2=80=98uuid=E2=80=99</div><div>drivers/nvme/host/core.c: In function =
=E2=80=98uuid_show=E2=80=99:</div><div>drivers/nvme/host/core.c:2292: error=
: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98uuid=
=E2=80=99</div><div>drivers/nvme/host/core.c:2297: error: =E2=80=98struct n=
vme_ns_head=E2=80=99 has no member named =E2=80=98uuid=E2=80=99</div><div>d=
rivers/nvme/host/core.c: In function =E2=80=98nvme_ns_attrs_are_visible=E2=
=80=99:</div><div>drivers/nvme/host/core.c:2333: error: =E2=80=98struct nvm=
e_ns_head=E2=80=99 has no member named =E2=80=98uuid=E2=80=99</div><div>dri=
vers/nvme/host/core.c: In function =E2=80=98nvme_make_request=E2=80=99:</di=
v><div>drivers/nvme/host/core.c:2506: error: =E2=80=98struct bio=E2=80=99 h=
as no member named =E2=80=98bi_disk=E2=80=99</div><div>drivers/nvme/host/co=
re.c:2508: error: implicit declaration of function =E2=80=98generic_make_re=
quest_fast=E2=80=99</div><div>drivers/nvme/host/core.c:2518: error: =E2=80=
=98struct bio=E2=80=99 has no member named =E2=80=98bi_status=E2=80=99</div=
><div>drivers/nvme/host/core.c:2518: error: =E2=80=98BLK_STS_IOERR=E2=80=99=
 undeclared (first use in this function)</div><div>drivers/nvme/host/core.c=
: In function =E2=80=98__nvme_find_ns_head=E2=80=99:</div><div>drivers/nvme=
/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no memb=
er named =E2=80=98entry=E2=80=99</div><div>drivers/nvme/host/core.c:2554: e=
rror: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98__m=
ptr=E2=80=99</div><div>drivers/nvme/host/core.c:2554: warning: initializati=
on from incompatible pointer type</div><div>drivers/nvme/host/core.c:2554: =
error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98e=
ntry=E2=80=99</div><div>drivers/nvme/host/core.c:2554: error: =E2=80=98stru=
ct nvme_ns_head=E2=80=99 has no member named =E2=80=98entry=E2=80=99</div><=
div>drivers/nvme/host/core.c:2554: error: =E2=80=98struct nvme_ns_head=E2=
=80=99 has no member named =E2=80=98entry=E2=80=99</div><div>drivers/nvme/h=
ost/core.c:2554: error: type defaults to =E2=80=98int=E2=80=99 in declarati=
on of =E2=80=98__mptr=E2=80=99</div><div>drivers/nvme/host/core.c:2554: err=
or: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98entr=
y=E2=80=99</div><div>drivers/nvme/host/core.c:2554: error: =E2=80=98struct =
nvme_ns_head=E2=80=99 has no member named =E2=80=98entry=E2=80=99</div><div=
>drivers/nvme/host/core.c:2555: error: =E2=80=98struct nvme_ns_head=E2=80=
=99 has no member named =E2=80=98ref=E2=80=99</div><div>drivers/nvme/host/c=
ore.c: In function =E2=80=98__nvme_check_ids=E2=80=99:</div><div>drivers/nv=
me/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no me=
mber named =E2=80=98entry=E2=80=99</div><div>drivers/nvme/host/core.c:2569:=
 error: type defaults to =E2=80=98int=E2=80=99 in declaration of =E2=80=98_=
_mptr=E2=80=99</div><div>drivers/nvme/host/core.c:2569: warning: initializa=
tion from incompatible pointer type</div><div>drivers/nvme/host/core.c:2569=
: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=
=98entry=E2=80=99</div><div>drivers/nvme/host/core.c:2569: error: =E2=80=98=
struct nvme_ns_head=E2=80=99 has no member named =E2=80=98entry=E2=80=99</d=
iv><div>drivers/nvme/host/core.c:2569: error: =E2=80=98struct nvme_ns_head=
=E2=80=99 has no member named =E2=80=98entry=E2=80=99</div><div>drivers/nvm=
e/host/core.c:2569: error: type defaults to =E2=80=98int=E2=80=99 in declar=
ation of =E2=80=98__mptr=E2=80=99</div><div>drivers/nvme/host/core.c:2569: =
error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98e=
ntry=E2=80=99</div><div>drivers/nvme/host/core.c:2569: error: =E2=80=98stru=
ct nvme_ns_head=E2=80=99 has no member named =E2=80=98entry=E2=80=99</div><=
div>drivers/nvme/host/core.c:2570: error: =E2=80=98struct nvme_ns_head=E2=
=80=99 has no member named =E2=80=98uuid=E2=80=99</div><div>drivers/nvme/ho=
st/core.c:2571: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member =
named =E2=80=98uuid=E2=80=99</div><div>drivers/nvme/host/core.c:2571: error=
: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98uuid=
=E2=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_all=
oc_ns_head=E2=80=99:</div><div>drivers/nvme/host/core.c:2599: error: =E2=80=
=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98ref=E2=80=99</=
div><div>drivers/nvme/host/core.c:2602: error: =E2=80=98struct nvme_ns_head=
=E2=80=99 has no member named =E2=80=98uuid=E2=80=99</div><div>drivers/nvme=
/host/core.c:2602: error: too many arguments to function =E2=80=98nvme_repo=
rt_ns_ids=E2=80=99</div><div>drivers/nvme/host/core.c:2622: error: =E2=80=
=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98instance=E2=80=
=99</div><div>drivers/nvme/host/core.c:2623: error: =E2=80=98struct nvme_ns=
_head=E2=80=99 has no member named =E2=80=98instance=E2=80=99</div><div>dri=
vers/nvme/host/core.c:2633: error: =E2=80=98struct nvme_ns_head=E2=80=99 ha=
s no member named =E2=80=98instance=E2=80=99</div><div>drivers/nvme/host/co=
re.c:2635: error: =E2=80=98struct nvme_ns_head=E2=80=99 has no member named=
 =E2=80=98entry=E2=80=99</div><div>drivers/nvme/host/core.c:2639: error: =
=E2=80=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98instance=
=E2=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_ini=
t_ns_head=E2=80=99:</div><div>drivers/nvme/host/core.c:2670: error: =E2=80=
=98uuid_t=E2=80=99 undeclared (first use in this function)</div><div>driver=
s/nvme/host/core.c:2670: error: expected =E2=80=98;=E2=80=99 before =E2=80=
=98uuid=E2=80=99</div><div>drivers/nvme/host/core.c:2672: error: =E2=80=98u=
uid=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvme=
/host/core.c:2672: error: too many arguments to function =E2=80=98nvme_repo=
rt_ns_ids=E2=80=99</div><div>drivers/nvme/host/core.c:2673: error: =E2=80=
=98struct nvme_ns_head=E2=80=99 has no member named =E2=80=98uuid=E2=80=99<=
/div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_setup_streams=
_ns=E2=80=99:</div><div>drivers/nvme/host/core.c:2722: error: storage size =
of =E2=80=98s=E2=80=99 isn=E2=80=99t known</div><div>drivers/nvme/host/core=
.c:2722: warning: unused variable =E2=80=98s=E2=80=99</div><div>drivers/nvm=
e/host/core.c:2964:33: error: macro &quot;NVME_VS&quot; passed 3 arguments,=
 but takes just 2</div><div>drivers/nvme/host/core.c: In function =E2=80=98=
nvme_scan_work=E2=80=99:</div><div>drivers/nvme/host/core.c:2964: error: =
=E2=80=98NVME_VS=E2=80=99 undeclared (first use in this function)</div><div=
>drivers/nvme/host/core.c: In function =E2=80=98nvme_ctrl_pp_status=E2=80=
=99:</div><div>drivers/nvme/host/core.c:3038: error: =E2=80=98NVME_CSTS_PP=
=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvme/ho=
st/core.c: In function =E2=80=98nvme_get_fw_slot_info=E2=80=99:</div><div>d=
rivers/nvme/host/core.c:3046: error: dereferencing pointer to incomplete ty=
pe</div><div>drivers/nvme/host/core.c:3051: error: =E2=80=98NVME_NSID_ALL=
=E2=80=99 undeclared (first use in this function)</div><div>drivers/nvme/ho=
st/core.c:3052: error: dereferencing pointer to incomplete type</div><div>d=
rivers/nvme/host/core.c:3054: error: dereferencing pointer to incomplete ty=
pe</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_complete_a=
sync_event=E2=80=99:</div><div>drivers/nvme/host/core.c:3095: error: derefe=
rencing pointer to incomplete type</div><div>drivers/nvme/host/core.c:3118:=
 error: =E2=80=98NVME_AER_NOTICE_FW_ACT_STARTING=E2=80=99 undeclared (first=
 use in this function)</div><div>drivers/nvme/host/core.c: In function =E2=
=80=98nvme_kill_queues=E2=80=99:</div><div>drivers/nvme/host/core.c:3294: e=
rror: implicit declaration of function =E2=80=98blk_mq_unquiesce_queue=E2=
=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_wait_f=
reeze_timeout=E2=80=99:</div><div>drivers/nvme/host/core.c:3330: error: imp=
licit declaration of function =E2=80=98blk_mq_freeze_queue_wait_timeout=E2=
=80=99</div><div>drivers/nvme/host/core.c: In function =E2=80=98nvme_wait_f=
reeze=E2=80=99:</div><div>drivers/nvme/host/core.c:3344: error: implicit de=
claration of function =E2=80=98blk_mq_freeze_queue_wait=E2=80=99</div><div>=
drivers/nvme/host/core.c: In function =E2=80=98nvme_start_freeze=E2=80=99:<=
/div><div>drivers/nvme/host/core.c:3355: error: implicit declaration of fun=
ction =E2=80=98blk_freeze_queue_start=E2=80=99</div><div>drivers/nvme/host/=
core.c: In function =E2=80=98nvme_stop_queues=E2=80=99:</div><div>drivers/n=
vme/host/core.c:3366: error: implicit declaration of function =E2=80=98blk_=
mq_quiesce_queue=E2=80=99</div><div>make[3]: *** [drivers/nvme/host/core.o]=
 Error 1</div><div>make[2]: *** [drivers/nvme/host] Error 2</div><div>make[=
1]: *** [drivers/nvme] Error 2</div><div>make: *** [drivers] Error 2</div><=
div>[root@cescel01 linux-4.8.17]#=C2=A0</div></div></td></tr></tbody></tabl=
e></td></tr></tbody></table></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2017-09-05 19:53 GMT+08:00 Christoph Hellwig <span dir=3D"=
ltr">&lt;<a href=3D"mailto:hch@infradead.org" target=3D"_blank">hch@infrade=
ad.org</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Aug 24, 20=
17 at 08:17:32PM +0000, Bart Van Assche wrote:<br>
&gt; For NVMe over RDMA, how about the simulate_network_failure_loop(<wbr>)=
 function in<br>
&gt; <a href=3D"https://github.com/bvanassche/srp-test/blob/master/lib/func=
tions" rel=3D"noreferrer" target=3D"_blank">https://github.com/bvanassche/<=
wbr>srp-test/blob/master/lib/<wbr>functions</a>? It simulates<br>
&gt; a network failure by writing into the reset_controller sysfs attribute=
.<br>
<br>
FYI, I&#39;ve tested lots of reset_controllers.=C2=A0 But automatic them is=
 of<br>
course even better.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
______________________________<wbr>_________________<br>
Linux-nvme mailing list<br>
<a href=3D"mailto:Linux-nvme@lists.infradead.org">Linux-nvme@lists.infradea=
d.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-nvme" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.infradead.org/<wbr>mailman/listin=
fo/linux-nvme</a><br>
</div></div></blockquote></div><br></div>

--001a114052dcb893980558e41f52--
