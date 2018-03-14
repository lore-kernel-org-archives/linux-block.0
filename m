Return-Path: <fengguang.wu@intel.com>
Date: Thu, 15 Mar 2018 03:39:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: kbuild-all@01.org,
	Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <201803150311.yGbwYKUS%fengguang.wu@intel.com>
References: <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Hi Jonas,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20180309]
[cannot apply to linus/master v4.16-rc4 v4.16-rc3 v4.16-rc2 v4.16-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jonas-Rabenstein/block-sed-opal-support-write-to-shadow-mbr/20180314-184749
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   block/sed-opal.c:381:20: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [unsigned] [usertype] align @@    got ed long long [unsigned] [usertype] align @@
   block/sed-opal.c:381:20:    expected unsigned long long [unsigned] [usertype] align
   block/sed-opal.c:381:20:    got restricted __be64 const [usertype] alignment_granularity
   block/sed-opal.c:382:25: sparse: incorrect type in assignment (different base types) @@    expected unsigned long long [unsigned] [usertype] lowest_lba @@    got ed long long [unsigned] [usertype] lowest_lba @@
   block/sed-opal.c:382:25:    expected unsigned long long [unsigned] [usertype] lowest_lba
   block/sed-opal.c:382:25:    got restricted __be64 const [usertype] lowest_aligned_lba
>> block/sed-opal.c:1526:58: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const [noderef] <asn:1>*from @@    got unsvoid const [noderef] <asn:1>*from @@
   block/sed-opal.c:1526:58:    expected void const [noderef] <asn:1>*from
   block/sed-opal.c:1526:58:    got unsigned char const [usertype] *
>> block/sed-opal.c:2100:14: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1>*<noident> @@    got onst volatile [noderef] <asn:1>*<noident> @@
   block/sed-opal.c:2100:14:    expected void const volatile [noderef] <asn:1>*<noident>
   block/sed-opal.c:2100:14:    got unsigned char const [usertype] *data

vim +1526 block/sed-opal.c

  1493	
  1494	static int write_shadow_mbr(struct opal_dev *dev, void *data)
  1495	{
  1496		struct opal_shadow_mbr *shadow = data;
  1497		size_t off;
  1498		u64 len;
  1499		int err = 0;
  1500		u8 *payload;
  1501	
  1502		/* FIXME: this is the maximum we can use for IO_BUFFER_LENGTH=2048.
  1503		 *        Instead of having constant, it would be nice to compute the
  1504		 *        actual value depending on IO_BUFFER_LENGTH
  1505		 */
  1506		len = 1950;
  1507	
  1508		/* do the actual transmission(s) */
  1509		for (off = 0 ; off < shadow->size; off += len) {
  1510			len = min(len, shadow->size - off);
  1511	
  1512			pr_debug("MBR: write bytes %zu+%llu/%llu\n",
  1513				 off, len, shadow->size);
  1514			err = start_opal_cmd(dev, opaluid[OPAL_MBR],
  1515					     opalmethod[OPAL_SET]);
  1516			add_token_u8(&err, dev, OPAL_STARTNAME);
  1517			add_token_u8(&err, dev, OPAL_WHERE);
  1518			add_token_u64(&err, dev, shadow->offset + off);
  1519			add_token_u8(&err, dev, OPAL_ENDNAME);
  1520	
  1521			add_token_u8(&err, dev, OPAL_STARTNAME);
  1522			add_token_u8(&err, dev, OPAL_VALUES);
  1523			payload = add_bytestring_header(&err, dev, len);
  1524			if (!payload)
  1525				break;
> 1526			if (copy_from_user(payload, shadow->data + off, len))
  1527				err = -EFAULT;
  1528	
  1529			add_token_u8(&err, dev, OPAL_ENDNAME);
  1530			if (err)
  1531				break;
  1532	
  1533			err = finalize_and_send(dev, parse_and_check_status);
  1534			if (err)
  1535				break;
  1536		}
  1537		return err;
  1538	}
  1539	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
