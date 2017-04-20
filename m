Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 20 Apr 2017 11:01:40 +0800
From: kbuild test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: kbuild-all@01.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v3] axon_ram: add dax_operations support
Message-ID: <201704201000.drxGPNHB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <149264111867.36586.15762148888692084363.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dan,

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.11-rc7 next-20170419]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dan-Williams/axon_ram-add-dax_operations-support/20170420-091615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/sysdev/axonram.c: In function 'axon_ram_dax_direct_access':
>> arch/powerpc/sysdev/axonram.c:176:31: error: implicit declaration of function 'dax_get_private' [-Werror=implicit-function-declaration]
     struct axon_ram_bank *bank = dax_get_private(dax_dev);
                                  ^~~~~~~~~~~~~~~
>> arch/powerpc/sysdev/axonram.c:176:31: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
   arch/powerpc/sysdev/axonram.c: At top level:
>> arch/powerpc/sysdev/axonram.c:181:21: error: variable 'axon_ram_dax_ops' has initializer but incomplete type
    static const struct dax_operations axon_ram_dax_ops = {
                        ^~~~~~~~~~~~~~
>> arch/powerpc/sysdev/axonram.c:182:2: error: unknown field 'direct_access' specified in initializer
     .direct_access = axon_ram_dax_direct_access,
     ^
   arch/powerpc/sysdev/axonram.c:182:19: error: excess elements in struct initializer [-Werror]
     .direct_access = axon_ram_dax_direct_access,
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/sysdev/axonram.c:182:19: note: (near initialization for 'axon_ram_dax_ops')
   arch/powerpc/sysdev/axonram.c: In function 'axon_ram_probe':
>> arch/powerpc/sysdev/axonram.c:255:18: error: implicit declaration of function 'alloc_dax' [-Werror=implicit-function-declaration]
     bank->dax_dev = alloc_dax(bank, bank->disk->disk_name,
                     ^~~~~~~~~
>> arch/powerpc/sysdev/axonram.c:255:16: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
     bank->dax_dev = alloc_dax(bank, bank->disk->disk_name,
                   ^
>> arch/powerpc/sysdev/axonram.c:313:3: error: implicit declaration of function 'kill_dax' [-Werror=implicit-function-declaration]
      kill_dax(bank->dax_dev);
      ^~~~~~~~
>> arch/powerpc/sysdev/axonram.c:314:3: error: implicit declaration of function 'put_dax' [-Werror=implicit-function-declaration]
      put_dax(bank->dax_dev);
      ^~~~~~~
   arch/powerpc/sysdev/axonram.c: At top level:
>> arch/powerpc/sysdev/axonram.c:181:36: error: storage size of 'axon_ram_dax_ops' isn't known
    static const struct dax_operations axon_ram_dax_ops = {
                                       ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/dax_get_private +176 arch/powerpc/sysdev/axonram.c

   170	};
   171	
   172	static long
   173	axon_ram_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
   174			       void **kaddr, pfn_t *pfn)
   175	{
 > 176		struct axon_ram_bank *bank = dax_get_private(dax_dev);
   177	
   178		return __axon_ram_direct_access(bank, pgoff, nr_pages, kaddr, pfn);
   179	}
   180	
 > 181	static const struct dax_operations axon_ram_dax_ops = {
 > 182		.direct_access = axon_ram_dax_direct_access,
   183	};
   184	
   185	/**
   186	 * axon_ram_probe - probe() method for platform driver
   187	 * @device: see platform_driver method
   188	 */
   189	static int axon_ram_probe(struct platform_device *device)
   190	{
   191		static int axon_ram_bank_id = -1;
   192		struct axon_ram_bank *bank;
   193		struct resource resource;
   194		int rc = 0;
   195	
   196		axon_ram_bank_id++;
   197	
   198		dev_info(&device->dev, "Found memory controller on %s\n",
   199				device->dev.of_node->full_name);
   200	
   201		bank = kzalloc(sizeof(struct axon_ram_bank), GFP_KERNEL);
   202		if (bank == NULL) {
   203			dev_err(&device->dev, "Out of memory\n");
   204			rc = -ENOMEM;
   205			goto failed;
   206		}
   207	
   208		device->dev.platform_data = bank;
   209	
   210		bank->device = device;
   211	
   212		if (of_address_to_resource(device->dev.of_node, 0, &resource) != 0) {
   213			dev_err(&device->dev, "Cannot access device tree\n");
   214			rc = -EFAULT;
   215			goto failed;
   216		}
   217	
   218		bank->size = resource_size(&resource);
   219	
   220		if (bank->size == 0) {
   221			dev_err(&device->dev, "No DDR2 memory found for %s%d\n",
   222					AXON_RAM_DEVICE_NAME, axon_ram_bank_id);
   223			rc = -ENODEV;
   224			goto failed;
   225		}
   226	
   227		dev_info(&device->dev, "Register DDR2 memory device %s%d with %luMB\n",
   228				AXON_RAM_DEVICE_NAME, axon_ram_bank_id, bank->size >> 20);
   229	
   230		bank->ph_addr = resource.start;
   231		bank->io_addr = (unsigned long) ioremap_prot(
   232				bank->ph_addr, bank->size, _PAGE_NO_CACHE);
   233		if (bank->io_addr == 0) {
   234			dev_err(&device->dev, "ioremap() failed\n");
   235			rc = -EFAULT;
   236			goto failed;
   237		}
   238	
   239		bank->disk = alloc_disk(AXON_RAM_MINORS_PER_DISK);
   240		if (bank->disk == NULL) {
   241			dev_err(&device->dev, "Cannot register disk\n");
   242			rc = -EFAULT;
   243			goto failed;
   244		}
   245	
   246	
   247		bank->disk->major = azfs_major;
   248		bank->disk->first_minor = azfs_minor;
   249		bank->disk->fops = &axon_ram_devops;
   250		bank->disk->private_data = bank;
   251	
   252		sprintf(bank->disk->disk_name, "%s%d",
   253				AXON_RAM_DEVICE_NAME, axon_ram_bank_id);
   254	
 > 255		bank->dax_dev = alloc_dax(bank, bank->disk->disk_name,
   256				&axon_ram_dax_ops);
   257		if (!bank->dax_dev) {
   258			rc = -ENOMEM;
   259			goto failed;
   260		}
   261	
   262		bank->disk->queue = blk_alloc_queue(GFP_KERNEL);
   263		if (bank->disk->queue == NULL) {
   264			dev_err(&device->dev, "Cannot register disk queue\n");
   265			rc = -EFAULT;
   266			goto failed;
   267		}
   268	
   269		set_capacity(bank->disk, bank->size >> AXON_RAM_SECTOR_SHIFT);
   270		blk_queue_make_request(bank->disk->queue, axon_ram_make_request);
   271		blk_queue_logical_block_size(bank->disk->queue, AXON_RAM_SECTOR_SIZE);
   272		device_add_disk(&device->dev, bank->disk);
   273	
   274		bank->irq_id = irq_of_parse_and_map(device->dev.of_node, 0);
   275		if (!bank->irq_id) {
   276			dev_err(&device->dev, "Cannot access ECC interrupt ID\n");
   277			rc = -EFAULT;
   278			goto failed;
   279		}
   280	
   281		rc = request_irq(bank->irq_id, axon_ram_irq_handler,
   282				AXON_RAM_IRQ_FLAGS, bank->disk->disk_name, device);
   283		if (rc != 0) {
   284			dev_err(&device->dev, "Cannot register ECC interrupt handler\n");
   285			bank->irq_id = 0;
   286			rc = -EFAULT;
   287			goto failed;
   288		}
   289	
   290		rc = device_create_file(&device->dev, &dev_attr_ecc);
   291		if (rc != 0) {
   292			dev_err(&device->dev, "Cannot create sysfs file\n");
   293			rc = -EFAULT;
   294			goto failed;
   295		}
   296	
   297		azfs_minor += bank->disk->minors;
   298	
   299		return 0;
   300	
   301	failed:
   302		if (bank != NULL) {
   303			if (bank->irq_id)
   304				free_irq(bank->irq_id, device);
   305			if (bank->disk != NULL) {
   306				if (bank->disk->major > 0)
   307					unregister_blkdev(bank->disk->major,
   308							bank->disk->disk_name);
   309				if (bank->disk->flags & GENHD_FL_UP)
   310					del_gendisk(bank->disk);
   311				put_disk(bank->disk);
   312			}
 > 313			kill_dax(bank->dax_dev);
 > 314			put_dax(bank->dax_dev);
   315			device->dev.platform_data = NULL;
   316			if (bank->io_addr != 0)
   317				iounmap((void __iomem *) bank->io_addr);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
c/g/1950jKt2AQA=

--M9NhX3UHpAaciwkO--
